import 'package:cashiru/core/constants/variables.dart';
import 'package:cashiru/data/datasource/auth_local_datasource.dart';
import 'package:cashiru/data/models/response/product_response_model.dart';
import 'package:dartz/dartz.dart';

class ProductRemoteDatasource {
    final AuthLocalDatasource _localDatasource;
    ProductRemoteDatasource({AuthLocalDatasource? localDatasource})
        : _localDatasource = localDatasource ?? AuthLocalDatasource();

  
  Future<Either<String, ProductResponseModel>> getProducts() async {
    final authData = await _localDatasource.getAuthData();
    final response = await Variables.httpClient.get(
      Uri.parse('${Variables.baseUrl}/api/products'),
      headers: {'Authorization': 'Bearer ${authData?.token}'},
    );

    if (response.statusCode == 200) {
      return right(ProductResponseModel.fromJson(response.body));
    } else {
      return left(response.body);
    }
  }
}
