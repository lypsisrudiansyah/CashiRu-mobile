import 'package:bloc/bloc.dart';
import 'package:cashiru/data/datasource/product_remote_datasource.dart';
import 'package:cashiru/data/models/response/product_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_bloc.freezed.dart';
part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRemoteDatasource productRemoteDatasource;
  List<Product> products = [];

  ProductBloc(this.productRemoteDatasource) : super(Initial()) {
    on<_FetchProducts>((event, emit) async {
      emit(Loading());
      final result = await productRemoteDatasource.getProducts();
      result.fold((failure) => emit(Failure(failure)), (success) {
        products = success.data ?? [];
        emit(Success(products));
      });
    });

    on<_FetchProductsByCategory>((event, emit) async {
      emit(Loading());
      final result = products.where((product) => product.categoryId == event.categoryId).toList();
      if (result.isNotEmpty) {
        emit(Success(result));
      } else {
        emit(Failure('No products found for this category'));
      }
    });

    on<_SearchProducts>((event, emit) async {
      emit(Loading());
      final result = products.where((product) => product.name!.toLowerCase().contains(event.query.toLowerCase())).toList();
      if (result.isNotEmpty) {
        emit(Success(result));
      } else {
        emit(Failure('No products found for this search query'));
      }
    });
  }
}
