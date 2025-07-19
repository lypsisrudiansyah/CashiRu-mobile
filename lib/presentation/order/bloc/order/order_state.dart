part of 'order_bloc.dart';

@freezed
class OrderState with _$OrderState {
  const factory OrderState.initial() = Initial;
  const factory OrderState.loading() = Loading;
  const factory OrderState.success(
    String paymentMethod,
    int nominalBayar,
    List<OrderItem> orders,
    int totalQuantity,
    int total,
  ) = Success;
  const factory OrderState.failure(String message) = Failure;
  
  const factory OrderState.addOrderSuccess(OrderResponseModel order) = AddOrderSuccess;
}
