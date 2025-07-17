import 'package:cashiru/core/constants/variables.dart';
import 'package:cashiru/data/datasource/auth_local_datasource.dart';
import 'package:cashiru/data/models/response/category_response_model.dart';
import 'package:dartz/dartz.dart';

class CategoryRemoteDatasource {
  final AuthLocalDatasource _localDatasource;
  CategoryRemoteDatasource({AuthLocalDatasource? localDatasource})
      : _localDatasource = localDatasource ?? AuthLocalDatasource();
  
  Future<Either<String, CategoryResponseModel>> getCategories() async {
    final authData = await _localDatasource.getAuthData();
    final Map<String, String> headers = {
      'Authorization': 'Bearer ${authData?.token}',
      'Accept': 'application/json',
    };
    final response = await Variables.httpClient.get(
      Uri.parse('${Variables.baseUrl}/api/categories'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return right(CategoryResponseModel.fromJson(response.body));
    } else {
      return left(response.body);
    }
  }
}
