import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  String toFormattedTime() {
    final List<String> monthNames = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'August',
      'September',
      'Oktober',
      'November',
      'Desember'
    ];

    final int hour12 = hour % 12;
    final String monthName = monthNames[month - 1];

    return '$day $monthName $year, ${hour12.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }

  String toFormattedDate() {
    final String date = DateFormat('EEEE, d MMM yyyy').format(this);

    return date;
  }
}
