part of 'history_bloc.dart';

@freezed
class HistoryState with _$HistoryState {
  const factory HistoryState.initial() = Initial;
  const factory HistoryState.loading() = Loading;
  const factory HistoryState.success(HistoryResponseModel data) = Success;
  const factory HistoryState.failure(String message) = Failure;
}
