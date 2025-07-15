import 'package:cashiru/data/models/response/category_response_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CategoryResponseModel', () {
    test('fromJson should parse valid response correctly', () {
      const jsonStr = '''
      {
        "message": "Success",
        "data": [
          {"id": 1, "name": "Electronics"},
          {"id": 2, "name": "Clothing"}
        ]
      }
      ''';

      final model = CategoryResponseModel.fromJson(jsonStr);

      expect(model.message, 'Success');
      expect(model.data, isNotNull);
      expect(model.data!.length, 2);
      expect(model.data![0].id, 1);
      expect(model.data![0].name, 'Electronics');
      expect(model.data![1].id, 2);
      expect(model.data![1].name, 'Clothing');
    });

    test('fromJson should handle null or missing data', () {
      const jsonStr = '''
      {
        "message": "Success",
        "data": null
      }
      ''';

      final model = CategoryResponseModel.fromJson(jsonStr);

      expect(model.message, 'Success');
      expect(model.data, isEmpty);
    });
  });

  group('Category', () {
    test('toMap should return correct map structure', () {
      final category = Category(id: 10, name: 'Books');
      final map = category.toMap();

      expect(map['id'], 10);
      expect(map['name'], 'Books');
    });

    test('fromMap should parse valid map correctly', () {
      final map = {"id": 5, "name": "Toys"};
      final category = Category.fromMap(map);

      expect(category.id, 5);
      expect(category.name, 'Toys');
    });
  });
}
