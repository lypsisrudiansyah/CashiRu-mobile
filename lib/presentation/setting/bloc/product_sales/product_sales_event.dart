part of 'product_sales_bloc.dart';

@freezed
class ProductSalesEvent with _$ProductSalesEvent {
  const factory ProductSalesEvent.started() = _Started;
  const factory ProductSalesEvent.getProductSalesReport(
    String startDate,
    String endDate,
  ) = _GetProductSalesReport;
}