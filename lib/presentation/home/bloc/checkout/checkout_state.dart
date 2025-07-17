part of 'checkout_bloc.dart';

@freezed
class CheckoutState with _$CheckoutState {
  const factory CheckoutState.initial() = Initial;
  const factory CheckoutState.loading() = Loading;
  const factory CheckoutState.success(List<OrderItem> products, int total, int qty) = Success;
  const factory CheckoutState.failure(String message) = Failure;
  const factory CheckoutState.empty() = Empty;
}
