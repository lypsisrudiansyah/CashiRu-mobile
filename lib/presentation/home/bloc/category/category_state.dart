part of 'category_bloc.dart';

@freezed
class CategoryState with _$CategoryState {
  const factory CategoryState.initial() = Initial;
  const factory CategoryState.loading() = Loading;
  const factory CategoryState.success(List<Category> categories) = Success;
  const factory CategoryState.failure(String message) = Failure;
}
