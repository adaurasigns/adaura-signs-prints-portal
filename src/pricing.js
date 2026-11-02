/**
 * AdAura Signs & Prints pricing rules.
 * All currency values are INR. Supplier rates are GST-inclusive.
 * Customer prices are GST-inclusive and must be recalculated server-side.
 */

export function roundPaise(amount) {
  return Math.round((Number(amount) + Number.EPSILON) * 100) / 100;
}

function validNumber(value, label, { min = 0, max = Infinity } = {}) {
  const n = Number(value);
  if (!Number.isFinite(n) || n < min || n > max) {
    throw new Error(`Invalid ${label}`);
  }
  return n;
}

export function quoteB2B({
  supplierRateInclusive, markupPercent = 20, minimumAddition = 50,
  gstRatePercent, quantity = 1,
}) {
  const costInclusive = validNumber(supplierRateInclusive, 'supplier rate');
  const markup = validNumber(markupPercent, 'B2B markup');
  const minimum = validNumber(minimumAddition, 'minimum addition');
  const gst = validNumber(gstRatePercent, 'GST rate', { max: 100 });
  const qty = validNumber(quantity, 'quantity', { min: Number.EPSILON });
  const addition = Math.max(costInclusive * markup / 100, minimum);
  const unitInclusive = roundPaise(costInclusive + addition);
  const unitExGst = roundPaise(unitInclusive / (1 + gst / 100));
  return {
    customerType: 'b2b',
    supplierRateInclusive: roundPaise(costInclusive),
    gstRatePercent: gst,
    unitPriceExGst: unitExGst,
    unitGst: roundPaise(unitInclusive - unitExGst),
    unitPriceInclusive: unitInclusive,
    quantity: qty,
    totalInclusive: roundPaise(unitInclusive * qty),
    markupPercent: markup,
    minimumAddition: minimum,
  };
}

/**
 * B2C: apply a 100% markup to the supplier's pre-GST rate, then add
 * the applicable output GST. Supplier GST-inclusive rate is divided by
 * (1 + GST rate) to obtain its pre-GST value.
 */
export function quoteB2C({
  supplierRateInclusive, gstRatePercent, markupPercent = 100, quantity = 1,
}) {
  const costInclusive = validNumber(supplierRateInclusive, 'supplier rate');
  const gst = validNumber(gstRatePercent, 'GST rate', { max: 100 });
  const markup = validNumber(markupPercent, 'B2C markup', { max: 10000 });
  const qty = validNumber(quantity, 'quantity', { min: Number.EPSILON });

  const costExGst = roundPaise(costInclusive / (1 + gst / 100));
  const sellingExGst = roundPaise(costExGst * (1 + markup / 100));
  const outputGst = roundPaise(sellingExGst * gst / 100);
  const sellingInclusive = roundPaise(sellingExGst + outputGst);

  return {
    customerType: 'b2c',
    supplierRateInclusive: roundPaise(costInclusive),
    supplierCostExGst: costExGst,
    gstRatePercent: gst,
    markupPercent: markup,
    unitPriceExGst: sellingExGst,
    unitGst: outputGst,
    unitPriceInclusive: sellingInclusive,
    quantity: qty,
    totalExGst: roundPaise(sellingExGst * qty),
    totalGst: roundPaise(outputGst * qty),
    totalInclusive: roundPaise(sellingInclusive * qty),
    policy: '100% markup on supplier cost before GST',
  };
}

export function quoteProduct({ customerType, ...inputs }) {
  if (customerType === 'b2b') return quoteB2B(inputs);
  if (customerType === 'b2c') return quoteB2C(inputs);
  throw new Error('Customer type must be b2b or b2c');
}

