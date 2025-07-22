import 'dart:convert';


import '../../home/models/order_item.dart';

class OrderModel {
  final int? id;
  final String paymentMethod;
  final int nominalBayar;
  final List<OrderItem> orders;
  final int totalQuantity;
  final int total;
  final int idKasir;
  final String namaKasir;
  final String transactionTime;
  final bool isSync;
  OrderModel({
    this.id,
    required this.paymentMethod,
    required this.nominalBayar,
    required this.orders,
    required this.totalQuantity,
    required this.total,
    required this.idKasir,
    required this.namaKasir,
    required this.isSync,
    required this.transactionTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'paymentMethod': paymentMethod,
      'nominalBayar': nominalBayar,
      'orders': orders.map((x) => x.toMap()).toList(),
      'totalQuantity': totalQuantity,
      'total': total,
      'idKasir': idKasir,
      'namaKasir': namaKasir,
      'isSync': isSync,
    };
  }

  //  mominal INTEGER,
  //       payment_method TEXT
  //       total_quantity INTEGER,
  //       id_kasir INTEGER,
  //       nama_kasir TEXT,
  //       is_sync INTEGER DEFAULT 0

  Map<String, dynamic> toMapForLocal() {
    return {
      'payment_method': paymentMethod,
      'total_quantity': totalQuantity,
      'nominal': total,
      'id_kasir': idKasir,
      'nama_kasir': namaKasir,
      'is_sync': isSync ? 1 : 0,
      'transaction_time': transactionTime,
    };
  }

  factory OrderModel.fromLocalMap(Map<String, dynamic> map) {
    return OrderModel(
      paymentMethod: map['payment_method'] ?? '',
      nominalBayar: map['nominal']?.toInt() ?? 0,
      orders: [],
      totalQuantity: map['total_quantity']?.toInt() ?? 0,
      total: map['nominal']?.toInt() ?? 0,
      idKasir: map['id_kasir']?.toInt() ?? 0,
      isSync: map['is_sync'] == 1 ? true : false,
      namaKasir: map['nama_kasir'] ?? '',
      id: map['id']?.toInt() ?? 0,
      transactionTime: map['transaction_time'] ?? '',
    );
  }

  factory OrderModel.newFromLocalMap(Map<String, dynamic> map, List<OrderItem> orders) {
    return OrderModel(
      paymentMethod: map['payment_method'] ?? '',
      nominalBayar: map['nominal']?.toInt() ?? 0,
      orders: orders,
      totalQuantity: map['total_quantity']?.toInt() ?? 0,
      total: map['nominal']?.toInt() ?? 0,
      idKasir: map['id_kasir']?.toInt() ?? 0,
      isSync: map['is_sync'] == 1 ? true : false,
      namaKasir: map['nama_kasir'] ?? '',
      id: map['id']?.toInt() ?? 0,
      transactionTime: map['transaction_time'] ?? '',
    );
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      paymentMethod: map['paymentMethod'] ?? '',
      nominalBayar: map['nominalBayar']?.toInt() ?? 0,
      orders:
          List<OrderItem>.from(map['orders']?.map((x) => OrderItem.fromMap(x))),
      totalQuantity: map['totalQuantity']?.toInt() ?? 0,
      total: map['total']?.toInt() ?? 0,
      idKasir: map['idKasir']?.toInt() ?? 0,
      isSync: map['isSync'] ?? false,
      namaKasir: map['namaKasir'] ?? '',
      id: map['id']?.toInt() ?? 0,
      transactionTime: map['transactionTime'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source));
}
