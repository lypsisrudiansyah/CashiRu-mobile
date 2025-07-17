import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'category_bloc.freezed.dart';
part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final Categorrep categoryRemoteDatasource;
  CategoryBloc(this.categoryRemoteDatasource) : super(Initial()) {
    on<_FetchCategories>((event, emit) async {
      emit(Loading());
      final result = await categoryRemoteDatasource.getCategories();
      result.fold(
        (failure) => emit(Failure(failure)),
        (success) => emit(Success(success.data ?? [])),
      );
    });
  }
}
