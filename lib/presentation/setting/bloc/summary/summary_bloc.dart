import 'package:bloc/bloc.dart';
import 'package:cashiru/data/datasource/report_remote_datasource.dart';
import 'package:cashiru/data/models/response/summary_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'summary_event.dart';
part 'summary_state.dart';
part 'summary_bloc.freezed.dart';

class SummaryBloc extends Bloc<SummaryEvent, SummaryState> {
  final ReportRemoteDatasource reportRemoteDatasource;

  SummaryBloc(this.reportRemoteDatasource) : super(Initial()) {
    // 
    on<_GetSummary>((event, emit) async {
      emit(Loading());
      final result = await reportRemoteDatasource.getSummaryReport(event.startDate, event.endDate);

      result.fold((error) => emit(Error(error)), (summary) => emit(Loaded(summary)));
    });
  }
}
