/// Same as backend utils/money.ts::roundMoney.
double roundMoney(double amount) => ((amount + 2.220446049250313e-16) * 100).round() / 100;

typedef DocumentLine = ({double quantity, double unitPrice, double taxRate});

typedef DocumentTotals = ({double subTotal, double discount, double tax, double total});

/// Mirrors taxCalculation.service.ts::calculateDocumentTax exactly —
/// discount spread across lines and applied *before* GST, every step
/// rounded to paise, and no tax at all when the tenant has GST off. A sale
/// or purchase paid in full sends this total as its paidAmount, so any
/// drift from the backend's total gets it rejected ("Paid amount cannot
/// exceed the ... total").
DocumentTotals computeDocumentTotals(
  List<DocumentLine> lines, {
  required double discountAmount,
  required bool gstEnabled,
}) {
  final lineSubs = [for (final l in lines) roundMoney(l.quantity * l.unitPrice)];
  final subTotal = roundMoney(lineSubs.fold(0.0, (s, v) => s + v));
  final safeDiscount = discountAmount.clamp(0.0, subTotal);
  var discountTotal = 0.0;
  var taxableTotal = 0.0;
  var taxTotal = 0.0;
  for (var i = 0; i < lines.length; i++) {
    final lineDiscount = subTotal > 0 ? roundMoney(safeDiscount * (lineSubs[i] / subTotal)) : 0.0;
    final taxable = roundMoney(lineSubs[i] - lineDiscount);
    final rate = gstEnabled ? lines[i].taxRate : 0.0;
    discountTotal = roundMoney(discountTotal + lineDiscount);
    taxableTotal = roundMoney(taxableTotal + taxable);
    taxTotal = roundMoney(taxTotal + roundMoney(taxable * (rate / 100)));
  }
  return (subTotal: subTotal, discount: discountTotal, tax: taxTotal, total: roundMoney(taxableTotal + taxTotal));
}
