
import 'package:bloc/bloc.dart';
import 'package:cashiru/data/datasource/auth_remote_datasource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRemoteDatasource authRemoteDatasource;
  LoginBloc(this.authRemoteDatasource) : super(Initial()) {
    on<_Login>((event, emit) async {
      emit(const Loading());
      final response = await authRemoteDatasource.login(
        event.email,
        event.password,
      );

      response.fold(
        (failure) => emit(Failure(failure)),
        (data) => emit(Success(data)),
      );
    });
  }
}
