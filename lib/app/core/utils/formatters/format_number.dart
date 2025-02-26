import 'package:intl/intl.dart';

const _CURRENCY_PATTERN = '\u00a4 #,##0.00#';
NumberFormat toHLGCurrency([bool compact = false]) {
  if (compact) {
    return NumberFormat.compactCurrency(
      locale: "fr",
      name: "HLG",
      symbol: "HLG",
      decimalDigits: 2,
    );
  }
  return NumberFormat.currency(
    locale: "fr",
    symbol: "HLG",
    name: "HLG",
    decimalDigits: 2,
    customPattern: _CURRENCY_PATTERN,
  );
}

final toUsCurrency = NumberFormat.currency(
  locale: "fr",
  symbol: r"$ ",
  name: "US",
  decimalDigits: 2,
  customPattern: _CURRENCY_PATTERN,
);
final numberFormater = NumberFormat(
  '#,##0.00#',
);
final numberFormaterCompact = NumberFormat.compact(locale: 'fr');
