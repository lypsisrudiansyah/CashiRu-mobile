import 'package:intl/intl.dart';

extension StringExt on String {
  int get toIntegerFromText {
    final cleanedText = replaceAll(RegExp(r'[^0-9]'), '');
    final parsedValue = int.tryParse(cleanedText) ?? 0;
    return parsedValue;
  }

  //transactionTime: DateFormat('yyyy-MM-ddTHH:mm:ss').format(DateTime.now())

  String get toFormattedTime {
    final dateTime = DateTime.parse(this);
    return DateFormat('dd-MM HH:mm').format(dateTime);
  }

  String get currencyFormatRp {
    final parsedValue = int.tryParse(this) ?? 0;
    return NumberFormat.currency(locale: 'id', symbol: 'Rp. ', decimalDigits: 0).format(parsedValue);
  }

  // without suffix 'Rp. '
  String get currencyFormatRpV2 {
    final parsedValue = int.tryParse(this) ?? 0;
    return NumberFormat.currency(locale: 'id', symbol: '', decimalDigits: 0).format(parsedValue);
  }

  int get toInt {
    return int.tryParse(this) ?? 0;
  }
}
