import 'package:cashiru/core/extensions/int_extension.dart';

class HistoryTransactionModel {
  final String name;
  final String category;
  final int price;

  HistoryTransactionModel({
    required this.name,
    required this.category,
    required this.price,
  });

  String get priceFormat => price.currencyFormatRp;
}
