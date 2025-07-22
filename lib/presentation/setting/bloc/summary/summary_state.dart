part of 'summary_bloc.dart';

@freezed
class SummaryState with _$SummaryState {
  const factory SummaryState.initial() = Initial;
  const factory SummaryState.loading() = Loading;
  const factory SummaryState.loaded(SummaryResponseModel summary) = Loaded;
  const factory SummaryState.error(String message) = Error;
}
