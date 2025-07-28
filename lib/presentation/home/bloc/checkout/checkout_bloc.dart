import 'package:bloc/bloc.dart';
import 'package:cashiru/data/models/response/product_response_model.dart';
import 'package:cashiru/presentation/home/models/order_item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';
part 'checkout_bloc.freezed.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc() : super(const Success([], 0, 0)) {
    on<_AddCheckout>((event, emit) {
      var currentStates = state as Success;
      List<OrderItem> newCheckout = [...currentStates.products];
      if (newCheckout.any((element) => element.product.id == event.product.id)) {
        var index = newCheckout.indexWhere((element) => element.product.id == event.product.id);
        newCheckout[index].quantity++;
      } else {
        newCheckout.add(OrderItem(product: event.product, quantity: 1));
      }
      int totalQuantity = 0;
      int total = 0;
      for (var element in newCheckout) {
        totalQuantity += element.quantity;
        total += element.quantity * double.parse(element.product.price!).toInt();
      }
      emit(Success(newCheckout, total, totalQuantity));
    });

    on<_RemoveCheckout>((event, emit) {
      var currentStates = state as Success;
      List<OrderItem> newCheckout = [...currentStates.products];

      if (newCheckout.any((element) => element.product.id == event.product.id)) {
        var index = newCheckout.indexWhere((element) => element.product.id == event.product.id);
        if (newCheckout[index].quantity > 1) {
          newCheckout[index].quantity--;
        } else {
          newCheckout.removeAt(index);
        }
      }
      int totalQuantity = 0;
      int total = 0;
      for (var element in newCheckout) {
        totalQuantity += element.quantity;
        total += element.quantity * double.parse(element.product.price!).toInt();
      }
      emit(Success(newCheckout, total, totalQuantity));
    });

    on<_DeleteItemCheckout>((event, emit) {
        print("Masuk DeleteITEM");

      var currentStates = state as Success;
      List<OrderItem> newCheckout = [...currentStates.products];

      final index = newCheckout.indexWhere((element) => (element.product.id) == event.product.id);
      if (index != -1) {
        newCheckout.removeAt(index);
      } else {
        print("Masuk Failure");
        emit(Failure("Cannot Find Order Item for this Action."));
      }
        print("Lolos IF ELSE");
      int totalQuantity = 0;
      int total = 0;
      for (var element in newCheckout) {
        totalQuantity += element.quantity;
        total += element.quantity * double.parse(element.product.price!).toInt();
      }
      // emit(Failure("There is no order item for this Action."));

      emit(Success(newCheckout, total, totalQuantity));
    });

    on<_Started>((event, emit) {
      emit(const Success([], 0, 0));
    });
  }
}
