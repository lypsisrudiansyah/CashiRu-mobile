part of 'product_bloc.dart';

@freezed
class ProductState with _$ProductState {
  const factory ProductState.initial() = Initial;
  const factory ProductState.loading() = Loading;
  const factory ProductState.success(List<Product> products) = Success;
  const factory ProductState.failure(String message) = Failure;
}
