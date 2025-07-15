import 'package:cashiru/data/models/response/category_response_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cashiru/data/models/response/product_response_model.dart';

void main() {
  group('Product.fromMap', () {
    test('parses correctly with all fields present', () {
      final map = {
        "id": 1,
        "name": "Product A",
        "description": "A nice product",
        "price": "10000",
        "category_id": 2,
        "image": "image.png",
        "stock": 10,
        "created_at": "2023-01-01T12:00:00.000Z",
        "updated_at": "2023-01-02T12:00:00.000Z",
        "category": {
          "id": 2,
          "name": "Category A",
        },
      };

      final product = Product.fromMap(map);

      expect(product.id, 1);
      expect(product.name, "Product A");
      expect(product.description, "A nice product");
      expect(product.price, "10000");
      expect(product.categoryId, 2);
      expect(product.image, "image.png");
      expect(product.stock, 10);
      expect(product.createdAt, DateTime.parse("2023-01-01T12:00:00.000Z"));
      expect(product.updatedAt, DateTime.parse("2023-01-02T12:00:00.000Z"));
      expect(product.category, isA<Category>());
      expect(product.category?.id, 2);
      expect(product.category?.name, "Category A");
    });

    test('parses correctly when nullable fields are null', () {
      final map = {
        "id": 1,
        "name": "Product A",
        "description": null,
        "price": null,
        "category_id": null,
        "image": null,
        "stock": null,
        "created_at": null,
        "updated_at": null,
        "category": null,
      };

      final product = Product.fromMap(map);

      expect(product.description, null);
      expect(product.price, null);
      expect(product.category, null);
      expect(product.createdAt, null);
      expect(product.updatedAt, null);
    });
  });
}
