import 'package:flutter_test/flutter_test.dart';
import 'package:cashiru/data/models/response/order_response_model.dart';
import 'package:cashiru/data/models/response/product_response_model.dart';

void main() {
  group('Order', () {
    test('fromMap parses all fields correctly', () {
      final map = {
        "transaction_number": "TRX123",
        "cashier_id": 1,
        "total": 10000,
        "total_quantity": 2,
        "payment_method": "cash",
        "updated_at": "2024-07-15T10:00:00.000Z",
        "created_at": "2024-07-14T09:00:00.000Z",
        "id": 42,
        "order_items": [
          {
            "id": 1,
            "order_id": 42,
            "product_id": 99,
            "quantity": 2,
            "total_item": "20000",
            "created_at": "2024-07-14T09:00:00.000Z",
            "updated_at": "2024-07-15T10:00:00.000Z",
            "product": {
              "id": 99,
              "name": "Product A",
              "price": 10000,
              "stock": 5,
              "created_at": "2024-07-10T08:00:00.000Z",
              "updated_at": "2024-07-15T10:00:00.000Z",
            },
          },
        ],
      };

      final order = Order.fromMap(map);

      expect(order.transactionNumber, "TRX123");
      expect(order.cashierId, 1);
      expect(order.total, 10000);
      expect(order.totalQuantity, 2);
      expect(order.paymentMethod, "cash");
      expect(order.updatedAt, DateTime.parse("2024-07-15T10:00:00.000Z"));
      expect(order.createdAt, DateTime.parse("2024-07-14T09:00:00.000Z"));
      expect(order.id, 42);
      expect(order.orderItems, isA<List<OrderItem>>());
      expect(order.orderItems!.length, 1);
      expect(order.orderItems![0].product!.name, "Product A");
    });

    test('fromMap handles null order_items', () {
      final map = {"transaction_number": "TRX123", "order_items": null};
      final order = Order.fromMap(map);
      expect(order.orderItems, []);
    });

    test('toMap outputs correct map', () {
      final order = Order(
        transactionNumber: "TRX123",
        cashierId: 1,
        total: 10000,
        totalQuantity: 2,
        paymentMethod: "cash",
        updatedAt: DateTime.parse("2024-07-15T10:00:00.000Z"),
        createdAt: DateTime.parse("2024-07-14T09:00:00.000Z"),
        id: 42,
        orderItems: [],
      );
      final map = order.toMap();
      expect(map["transaction_number"], "TRX123");
      expect(map["order_items"], []);
    });
  });

  group('OrderItem', () {
    test('fromMap parses nested product correctly', () {
      final map = {
        "id": 1,
        "order_id": 42,
        "product_id": 99,
        "quantity": 2,
        "total_item": "20000",
        "created_at": "2024-07-14T09:00:00.000Z",
        "updated_at": "2024-07-15T10:00:00.000Z",
        "product": {
          "id": 99,
          "name": "Product A",
          "price": 10000,
          "stock": 5,
          "created_at": "2024-07-10T08:00:00.000Z",
          "updated_at": "2024-07-15T10:00:00.000Z",
        },
      };
      final item = OrderItem.fromMap(map);
      expect(item.product, isA<Product>());
      expect(item.product!.name, "Product A");
      expect(item.createdAt, DateTime.parse("2024-07-14T09:00:00.000Z"));
    });

    test('fromMap handles null product', () {
      final map = {"id": 1, "product": null};
      final item = OrderItem.fromMap(map);
      expect(item.product, null);
    });

    test('toMap outputs correct map', () {
      final item = OrderItem(
        id: 1,
        orderId: 42,
        productId: 99,
        quantity: 2,
        totalItem: "20000",
        createdAt: DateTime.parse("2024-07-14T09:00:00.000Z"),
        updatedAt: DateTime.parse("2024-07-15T10:00:00.000Z"),
        product: null,
      );
      final map = item.toMap();
      expect(map["id"], 1);
      expect(map["product"], null);
    });
  });
}
