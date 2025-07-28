import 'package:cashiru/core/constants/variables.dart';
import 'package:cashiru/data/datasource/auth_local_datasource.dart';
import 'package:cashiru/data/models/response/product_sales_response_model.dart';
import 'package:cashiru/data/models/response/summary_response_model.dart';
import 'package:dartz/dartz.dart';

class ReportRemoteDatasource {
  final AuthLocalDatasource _localDatasource;
  ReportRemoteDatasource({AuthLocalDatasource? localDatasource}) : _localDatasource = localDatasource ?? AuthLocalDatasource();

  Future<Either<String, SummaryResponseModel>> getSummaryReport(String startDate, String endDate) async {
    final authData = await _localDatasource.getAuthData();
    final response = await Variables.httpClient.get(
      Uri.parse('${Variables.baseUrl}/api/reports/summary?start_date=$startDate&end_date=$endDate'),
      headers: {'Authorization': 'Bearer ${authData?.token}'},
    );
    if (response.statusCode == 200) {
      return right(SummaryResponseModel.fromJson(response.body));
    } else {
      return left(response.body);
    }
  }

  Future<Either<String, ProductSalesResponseModel>> getProductSales(String startDate, String endDate) async {
    final authData = await _localDatasource.getAuthData();
    final response = await Variables.httpClient.get(
      Uri.parse('${Variables.baseUrl}/api/reports/product-sales?start_date=$startDate&end_date=$endDate'),
      headers: {'Authorization': 'Bearer ${authData?.token}', 'Content-Type': 'application/json'},
    );
  print("${response.body.toString() }APA INI");
    if (response.statusCode == 200) {
      return right(ProductSalesResponseModel.fromJson(response.body));
    } else {
      return left(response.body);
    }
  }
}
