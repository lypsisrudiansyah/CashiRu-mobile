import 'dart:convert';

import 'package:cashiru/core/constants/variables.dart';
import 'package:cashiru/data/datasource/auth_local_datasource.dart';
import 'package:cashiru/data/models/request/order_request_model.dart';
import 'package:cashiru/data/models/response/history_response_model.dart';
import 'package:cashiru/data/models/response/order_response_model.dart';
import 'package:dartz/dartz.dart';

class OrderRemoteDatasource {
  final AuthLocalDatasource _localDatasource;
  OrderRemoteDatasource({AuthLocalDatasource? localDatasource}) : _localDatasource = localDatasource ?? AuthLocalDatasource();

  Future<Either<String, OrderResponseModel>> order(OrderRequestModel data) async {
    final authData = await _localDatasource.getAuthData();
    final response = await Variables.httpClient.post(
      Uri.parse('${Variables.baseUrl}/api/orders'),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer ${authData?.token}', 'Accept': 'application/json'},
      body: data.toJson(),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return right(OrderResponseModel.fromJson(response.body));
    } else {
      return left(response.body);
    }
  }

  Future<Either<String, HistoryResponseModel>> getOrders() async {
    final authData = await _localDatasource.getAuthData();
    final response = await Variables.httpClient.get(
      Uri.parse('${Variables.baseUrl}/api/orders'),
      headers: {'Authorization': 'Bearer ${authData?.token}', 'Accept': 'application/json'},
    );

    final decoded = jsonDecode(response.body);
    print(decoded);

    if (response.statusCode == 200) {
      return right(HistoryResponseModel.fromJson(response.body));
    } else {
      return left(response.body);
    }
  }
}
