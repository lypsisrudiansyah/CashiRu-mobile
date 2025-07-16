import 'dart:convert';

import 'package:cashiru/data/models/response/category_response_model.dart';

class ProductResponseModel {
  final String? message;
  final List<Product>? data;

  ProductResponseModel({this.message, this.data});

  factory ProductResponseModel.fromJson(String str) => ProductResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductResponseModel.fromMap(Map<String, dynamic> json) => ProductResponseModel(
    message: json["message"],
    data: json["data"] == null ? [] : List<Product>.from(json["data"]!.map((x) => Product.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {"message": message, "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap()))};
}

class Product {
  final int? id;
  final String? name;
  final String? description;
  final String? price;
  final int? categoryId;
  final String? image;
  final int? stock;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Category? category;

  Product({this.id, this.name, this.description, this.price, this.categoryId, this.image, this.stock, this.createdAt, this.updatedAt, this.category});

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    price: json["price"] ,
    categoryId: json["category_id"],
    image: json["image"],
    stock: json["stock"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    category: json["category"] == null ? null : Category.fromMap(json["category"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "description": description,
    "price": price,
    "category_id": categoryId,
    "image": image,
    "stock": stock,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "category": category?.toMap(),
  };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.price == price &&
        other.categoryId == categoryId &&
        other.image == image &&
        other.stock == stock &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.category == category;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        price.hashCode ^
        categoryId.hashCode ^
        image.hashCode ^
        stock.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        category.hashCode;
  }
}
