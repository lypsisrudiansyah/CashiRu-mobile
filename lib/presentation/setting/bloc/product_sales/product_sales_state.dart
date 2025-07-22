part of 'product_sales_bloc.dart';

@freezed
class ProductSalesState with _$ProductSalesState {
  const factory ProductSalesState.initial() = Initial;
  const factory ProductSalesState.loading() = Loading;
  const factory ProductSalesState.loaded(ProductSalesResponseModel productSales) = Loaded;
  const factory ProductSalesState.error(String message) = Error;
}
