part of 'logout_bloc.dart';

@freezed
class LogoutState with _$LogoutState {
  const factory LogoutState.initial() = Initial;
  const factory LogoutState.loading() = Loading;
  const factory LogoutState.success() = Success;
  const factory LogoutState.failure(String message) = Failure;
}
