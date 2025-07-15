import 'dart:convert';

class OrderRequestModel {
    final int? cashierId;
    final String paymentMethod;
    final List<Item>? items;

    OrderRequestModel({
        this.cashierId,
        this.items,
        this.paymentMethod = "CASH",
    });

    factory OrderRequestModel.fromJson(String str) => OrderRequestModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory OrderRequestModel.fromMap(Map<String, dynamic> json) => OrderRequestModel(
        cashierId: json["cashier_id"],
        items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "cashier_id": cashierId,
        "payment_method": paymentMethod,
        "items": items == null ? [] : List<dynamic>.from(items!.map((item) => item.toMap())),
    };
}

class Item {
    final int? productId;
    final int? quantity;

    Item({
        this.productId,
        this.quantity,
    });

    factory Item.fromJson(String str) => Item.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Item.fromMap(Map<String, dynamic> json) => Item(
        productId: json["product_id"],
        quantity: json["quantity"],
    );

    Map<String, dynamic> toMap() => {
        "product_id": productId,
        "quantity": quantity,
    };
}
