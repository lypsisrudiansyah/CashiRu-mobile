import 'package:cashiru/data/datasource/order_remote_datasource.dart';
import 'package:cashiru/data/models/request/order_request_model.dart';
import 'package:cashiru/data/models/response/order_response_model.dart' hide OrderItem;
import 'package:cashiru/presentation/home/models/order_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_bloc.freezed.dart';
part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRemoteDatasource orderRemoteDatasource;
  OrderBloc(this.orderRemoteDatasource) : super(const Success('', 0, [], 0, 0)) {
    on<_AddPaymentMethod>((event, emit) async {
      emit(const Loading());
      try {
        await Future.delayed(const Duration(seconds: 1));

        emit(
          Success(
            event.paymentMethod,
            0, // Nominal bayar is not set yet
            event.orders,
            event.totalQuantity,
            event.total,
          ),
        );
      } catch (e) {
        emit(Failure(e.toString()));
      }
    });

    on<_AddNominal>((event, emit) {
      var currentState = state as Success;
      // Update the amount pay in the current state
      emit(
        Success(
          currentState.paymentMethod,
          event.nominalBayar,
          currentState.orders,
          currentState.totalQuantity,
          currentState.total,
        ),
      );
    });

    on<_Started>((event, emit) {
      emit(const Success('', 0, [], 0, 0));
    });

    on<_AddOrder>((event, emit) async {
      var currentState = state as Success;
      try {
        final response = await orderRemoteDatasource.order(event.order);
        response.fold((failure) => emit(Failure(failure)), (orderResponse) {
          if (orderResponse.data != null) {
            emit(
              Success(
                currentState.paymentMethod,
                currentState.nominalBayar,
                currentState.orders,
                currentState.totalQuantity,
                currentState.total,
              ),
            );
          } else {
            emit(Failure(orderResponse.message ?? 'Unknown error'));
          }
        });
      } catch (e) {
        emit(Failure(e.toString()));
      }
    });
  }
}
