import 'package:flutter_test/flutter_test.dart';
import 'package:cashiru/data/models/response/product_sales_response_model.dart';

void main() {
  group('ProductSales', () {
    test('fromMap parses all fields and converts productPrice correctly', () {
      final map = {
        'product_id': 1,
        'product_name': 'Produk A',
        'product_price': '15000',
        'total_quantity': '10',
        'total': '150000',
      };

      final sales = ProductSales.fromMap(map);

      expect(sales.productId, 1);
      expect(sales.productName, 'Produk A');
      expect(sales.productPrice, 15000);
      expect(sales.totalQuantity, '10');
      expect(sales.total, '150000');
    });

    test('fromMap throws if product_price is not a valid number', () {
      final map = {
        'product_id': 1,
        'product_name': 'Produk A',
        'product_price': 'invalid',
        'total_quantity': '10',
        'total': '150000',
      };

      expect(() => ProductSales.fromMap(map), throwsA(isA<FormatException>()));
    });

    test('fromJson parses JSON string correctly', () {
      final jsonStr = '''
      {
        "product_id": 2,
        "product_name": "Produk B",
        "product_price": "20000",
        "total_quantity": "5",
        "total": "100000"
      }
      ''';

      final sales = ProductSales.fromJson(jsonStr);

      expect(sales.productId, 2);
      expect(sales.productName, 'Produk B');
      expect(sales.productPrice, 20000);
      expect(sales.totalQuantity, '5');
      expect(sales.total, '100000');
    });
  });
}