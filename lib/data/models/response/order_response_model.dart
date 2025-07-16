import 'dart:convert';

import 'package:cashiru/data/models/response/product_response_model.dart';

class OrderResponseModel {
  final String? message;
  final Order? data;

  OrderResponseModel({this.message, this.data});

  factory OrderResponseModel.fromJson(String str) => OrderResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrderResponseModel.fromMap(Map<String, dynamic> json) =>
      OrderResponseModel(message: json["message"], data: json["data"] == null ? null : Order.fromMap(json["data"]));

  Map<String, dynamic> toMap() => {"message": message, "data": data?.toMap()};
}

class Order {
  final String? transactionNumber;
  final int? cashierId;
  final int? total;
  final int? totalQuantity;
  final String? paymentMethod;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? id;
  final List<OrderItem>? orderItems;

  Order({
    this.transactionNumber,
    this.cashierId,
    this.total,
    this.totalQuantity,
    this.paymentMethod,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.orderItems,
  });

  factory Order.fromJson(String str) => Order.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Order.fromMap(Map<String, dynamic> json) => Order(
    transactionNumber: json["transaction_number"],
    cashierId: json["cashier_id"],
    total: json["total"],
    totalQuantity: json["total_quantity"],
    paymentMethod: json["payment_method"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    id: json["id"],
    orderItems: json["order_items"] == null ? [] : List<OrderItem>.from(json["order_items"]!.map((x) => OrderItem.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "transaction_number": transactionNumber,
    "cashier_id": cashierId,
    "total": total,
    "total_quantity": totalQuantity,
    "payment_method": paymentMethod,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "id": id,
    "order_items": orderItems == null ? [] : List<dynamic>.from(orderItems!.map((x) => x.toMap())),
  };
}

class OrderItem {
  final int? id;
  final int? orderId;
  final int? productId;
  final int? quantity;
  final String? totalItem;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Product? product;

  OrderItem({this.id, this.orderId, this.productId, this.quantity, this.totalItem, this.createdAt, this.updatedAt, this.product});

  factory OrderItem.fromJson(String str) => OrderItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrderItem.fromMap(Map<String, dynamic> json) => OrderItem(
    id: json["id"],
    orderId: json["order_id"],
    productId: json["product_id"],
    quantity: json["quantity"],
    totalItem: json["total_item"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    product: json["product"] == null ? null : Product.fromMap(json["product"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "order_id": orderId,
    "product_id": productId,
    "quantity": quantity,
    "total_item": totalItem,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "product": product?.toMap(),
  };
}
