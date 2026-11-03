# AdAura on Oracle Cloud Always Free (Ubuntu ARM64)

This deployment targets one Oracle Cloud Infrastructure (OCI) VM running Ubuntu 24.04 LTS ARM64 and the VM.Standard.A1.Flex shape. It keeps the current Node.js + Express + SQLite application; no Supabase service is used.

## Important OCI limits and caveats

Oracle's current Always Free documentation describes a monthly allowance equivalent to **2 OCPUs and 12 GB RAM total** for Ampere A1 compute, plus **200 GB total block-volume storage** shared across boot and attached block volumes. This is not the older 4 OCPU / 24 GB figure quoted on some older pages. Create resources in the tenancy's home region and confirm the Console explicitly labels the selected resources Always Free before launching.

The A1 idle-instance policy is important for a low-traffic website: Oracle says an A1 instance may be reclaimed when, over a 7-day period, CPU 95th-percentile utilization, network utilization and memory utilization are all below 20%. A small portal may be quiet enough to meet those thresholds. This is free-tier infrastructure, not an uptime guarantee. Keep off-instance backups and do not treat it as the only copy of customer data.

Always Free accounts do not include an Oracle support SLA. Free-capacity shortages can also prevent instance creation in the selected home region.

## Recommended instance settings

- Image: **Ubuntu 24.04 LTS**, ARM64 (select the regular Ubuntu image, not Minimal Ubuntu for the A1 shape).
- Shape: **VM.Standard.A1.Flex**, up to 2 OCPUs and 12 GB memory total for this one Always Free instance.
- Boot volume: start with 50 GB; it counts against the total block-volume allowance.
- Networking: public subnet with an ephemeral public IPv4 address.
- SSH: add your own SSH public key. Store the private key safely on your computer; never paste it into GitHub or ChatGPT.
- Availability: use the home region you chose at signup. In India, compare the offered Mumbai and Hyderabad options before finalising your home region; the home region is not something to casually change later.

## Launch procedure

1. Create/sign in to your Oracle Cloud Free Tier account at https://www.oracle.com/cloud/free/.
2. Select a home region near your users, subject to A1 capacity. The Always Free compute resources must be created in that home region.
3. In Compute > Instances > Create instance, select the Ubuntu 24.04 LTS ARM64 platform image and VM.Standard.A1.Flex. Allocate no more than 2 OCPUs and 12 GB RAM in total across A1 instances.
4. Ensure the instance is in a public subnet and assign a public IPv4 address.
5. Add an SSH key pair. If OCI generates the pair, download the private key and keep it private.
6. Under Advanced options > Management > Cloud-init script, paste the complete contents of `oci/cloud-init.yaml` from this repository.
7. In the VCN subnet's Security List or the instance's Network Security Group, add ingress TCP rules:
   - TCP 22 from **your own current public IP /32** for SSH administration.
   - TCP 80 from 0.0.0.0/0 for the initial HTTP reverse proxy and certificate validation.
   - TCP 443 from 0.0.0.0/0 for HTTPS.
   Do not expose TCP 3000. The application binds behind Nginx on localhost.
8. Launch only if the Console identifies the selected A1 shape and boot volume as Always Free eligible. If you see an out-of-capacity error, do not upgrade to a paid shape merely to get past it; try another availability domain if offered or try again later.

The cloud-init script installs Node.js 22, build tools for ARM native modules, Nginx, SQLite, UFW and Certbot; clones this public GitHub branch; installs dependencies; runs the tests; creates a locked-down service user; and starts the app under systemd. First boot can take several minutes. Check OCI's cloud-init output or connect using SSH and run:

```bash
sudo cloud-init status --long
sudo systemctl status adaura-portal --no-pager
sudo systemctl status nginx --no-pager
curl -sS http://127.0.0.1:3000/api/health
```

## First administrator

The portal does not create a default admin account. After the instance is installed, SSH into it and set the administrator credentials:

```bash
sudo nano /etc/adaura-portal.env
```

Set `ADMIN_EMAIL` to the administrator's email and `ADMIN_PASSWORD` to a unique password of at least 16 characters. Save, then run:

```bash
sudo systemctl restart adaura-portal
sudo journalctl -u adaura-portal -n 50 --no-pager
```

The first startup with those values creates the admin account in SQLite. After confirming you can sign in at `/admin.html`, remove the `ADMIN_EMAIL` and `ADMIN_PASSWORD` values from the environment file and restart. The stored account remains in the database. Never send the password or SSH private key to anyone.

## HTTPS and domain

A real public customer beta should use HTTPS before real users register or upload artwork. Point your domain's A record to the instance's public IPv4 address. Wait for DNS to resolve, then run:

```bash
sudo certbot --nginx -d YOUR_DOMAIN
```

Use an email address when Certbot prompts for renewal notices. Certbot configures Nginx HTTPS and automatic renewal. Test `https://YOUR_DOMAIN/api/health`, `https://YOUR_DOMAIN/` and `https://YOUR_DOMAIN/admin.html`. Do not invite customers to use the HTTP-only URL for real accounts.

## Data, backups and updates

- SQLite database and persistent sessions: `/var/lib/adaura/adaura.sqlite`.
- Uploaded artwork: `/var/lib/adaura/uploads/`.
- Daily backup: 02:15 UTC, stored under `/var/backups/adaura/`, keeping 14 days locally.
- Run a manual backup: `sudo /usr/local/sbin/adaura-backup`.
- Update to the latest commit on the portal branch: `sudo /usr/local/sbin/adaura-update`.

The local backup is on the same VM disk and is not disaster recovery. Periodically copy backups to a separate location such as a trusted computer or separately configured object storage, and test restoring them. Never commit the SQLite database, uploads, SSH keys or environment file to Git.

## Operational notes

- The app is a single-instance SQLite deployment. Do not start a second application replica against the same database.
- Nginx is the only public-facing web server; application port 3000 remains local.
- UFW is enabled for ports 22, 80 and 443. OCI VCN security rules must independently allow those same inbound ports.
- Run OS updates regularly: `sudo apt update && sudo apt upgrade`.
- Check logs with `sudo journalctl -u adaura-portal -f` and `sudo tail -f /var/log/nginx/error.log`.
- This portal is still a beta foundation: product catalogue import, GST review, email verification/password reset, payment gateway, invoice generation and malware scanning are not yet complete. Use test records until these are addressed.
