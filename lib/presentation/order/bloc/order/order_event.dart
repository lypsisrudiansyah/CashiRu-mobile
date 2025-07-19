part of 'order_bloc.dart';

@freezed
class OrderEvent with _$OrderEvent {
  const factory OrderEvent.started() = _Started;
  const factory OrderEvent.addPaymentMethod(
    String paymentMethod,
    List<OrderItem> orders,
    int totalQuantity,
    int total,
  ) = _AddPaymentMethod;

  const factory OrderEvent.addNominal(int nominalBayar) = _AddNominal;

  const factory OrderEvent.addOrder(OrderRequestModel order) = _AddOrder;
}
