import 'package:bloc/bloc.dart';
import 'package:cashiru/data/datasource/order_remote_datasource.dart';
import 'package:cashiru/data/models/response/history_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'history_event.dart';
part 'history_state.dart';
part 'history_bloc.freezed.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final OrderRemoteDatasource orderRemoteDatasource;

  HistoryBloc(this.orderRemoteDatasource) : super(Initial()) {
    on<HistoryEvent>((event, emit) async {
      emit(const Loading());
      final result = await orderRemoteDatasource.getOrders();
      result.fold((failure) => emit(Failure(failure)), (success) => emit(Success(success)));
    });
  }
}
