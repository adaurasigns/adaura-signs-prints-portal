import { describe, it } from 'node:test';
import assert from 'node:assert/strict';
import { quoteB2C, quoteB2B } from './pricing.js';

describe('AdAura Signs & Prints pricing', () => {
  it('B2C doubles pre-GST cost, then adds GST', () => {
    const q = quoteB2C({ supplierRateInclusive: 118, gstRatePercent: 18 });
    assert.equal(q.supplierCostExGst, 100);
    assert.equal(q.unitPriceExGst, 200);
    assert.equal(q.unitGst, 36);
    assert.equal(q.unitPriceInclusive, 236);
    assert.equal(q.markupPercent, 100);
  });

  it('B2C handles a different product GST rate', () => {
    const q = quoteB2C({ supplierRateInclusive: 112, gstRatePercent: 12 });
    assert.equal(q.supplierCostExGst, 100);
    assert.equal(q.unitPriceExGst, 200);
    assert.equal(q.unitGst, 24);
    assert.equal(q.unitPriceInclusive, 224);
  });

  it('B2C supports quantity', () => {
    const q = quoteB2C({
      supplierRateInclusive: 118, gstRatePercent: 18, quantity: 3,
    });
    assert.equal(q.totalInclusive, 708);
  });

  it('B2C requires an explicit GST rate', () => {
    assert.throws(() => quoteB2C({ supplierRateInclusive: 118 }));
  });

  it('B2B retains the initial 20% / ₹50 minimum addition rule', () => {
    const q = quoteB2B({
      supplierRateInclusive: 188, markupPercent: 20,
      minimumAddition: 50, gstRatePercent: 18,
    });
    assert.equal(q.unitPriceInclusive, 238);
  });
});
