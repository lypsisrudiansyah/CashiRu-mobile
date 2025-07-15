import 'dart:convert';

class SummaryResponseModel {
  final String status;
  final Summary data;

  SummaryResponseModel({
    required this.status,
    required this.data,
  });

  factory SummaryResponseModel.fromMap(Map<String, dynamic> map) {
    return SummaryResponseModel(
      status: map['status'] as String,
      data: Summary.fromMap(map['data'] as Map<String, dynamic>),
    );
  }

  factory SummaryResponseModel.fromJson(String source) =>
      SummaryResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Summary {
  final int totalRevenue;
  final int totalSoldQuantity;

  Summary({
    required this.totalRevenue,
    required this.totalSoldQuantity,
  });

  factory Summary.fromMap(Map<String, dynamic> map) {
    return Summary(
        totalRevenue: map['total_revenue'] as int,
        totalSoldQuantity: map['total_sold_quantity'] is String
            ? int.parse(map['total_sold_quantity'])
            : map['total_sold_quantity']);
  }

  factory Summary.fromJson(String source) =>
      Summary.fromMap(json.decode(source) as Map<String, dynamic>);
}
