import 'package:cashiru/data/models/response/summary_response_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Summary.fromMap', () {
    test('parses correctly when total_sold_quantity is int', () {
      final map = {
        'total_revenue': 5000,
        'total_sold_quantity': 120,
      };

      final summary = Summary.fromMap(map);

      expect(summary.totalRevenue, 5000);
      expect(summary.totalSoldQuantity, 120);
    });

    test('parses correctly when total_sold_quantity is string', () {
      final map = {
        'total_revenue': 5000,
        'total_sold_quantity': '120',
      };

      final summary = Summary.fromMap(map);

      expect(summary.totalRevenue, 5000);
      expect(summary.totalSoldQuantity, 120);
    });

    test('throws if total_sold_quantity is string but not a number', () {
      final map = {
        'total_revenue': 5000,
        'total_sold_quantity': 'abc',
      };

      expect(() => Summary.fromMap(map), throwsA(isA<FormatException>()));
    });
  });
}
