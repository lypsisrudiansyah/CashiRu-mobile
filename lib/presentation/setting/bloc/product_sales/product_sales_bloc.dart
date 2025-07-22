import 'package:bloc/bloc.dart';
import 'package:cashiru/data/datasource/report_remote_datasource.dart';
import 'package:cashiru/data/models/response/product_sales_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_sales_bloc.freezed.dart';
part 'product_sales_event.dart';
part 'product_sales_state.dart';

class ProductSalesBloc extends Bloc<ProductSalesEvent, ProductSalesState> {
  final ReportRemoteDatasource reportRemoteDatasource;
  ProductSalesBloc(this.reportRemoteDatasource) : super(Initial()) {
    on<_GetProductSalesReport>((event, emit) async {
      emit(Loading());
      final result = await reportRemoteDatasource.getProductSales(event.startDate, event.endDate);

      result.fold((error) => emit(Error(error)), (productSales) => emit(Loaded(productSales)));
    });
  }
}
