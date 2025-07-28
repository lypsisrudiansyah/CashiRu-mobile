import 'package:cashiru/data/datasource/category_remote_datasource.dart';
import 'package:cashiru/data/datasource/order_remote_datasource.dart';
import 'package:cashiru/data/datasource/product_remote_datasource.dart';
import 'package:cashiru/presentation/auth/bloc/login/login_bloc.dart';
import 'package:cashiru/presentation/auth/bloc/logout/logout_bloc.dart';
import 'package:cashiru/presentation/home/bloc/category/category_bloc.dart';
import 'package:cashiru/presentation/home/bloc/checkout/checkout_bloc.dart';
import 'package:cashiru/presentation/home/bloc/product/product_bloc.dart';
import 'package:cashiru/presentation/order/bloc/order/order_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:cashiru/data/datasource/auth_remote_datasource.dart';
import 'package:cashiru/data/datasource/auth_local_datasource.dart';
// import 'package:cashiru/presentation/bloc/login/login_bloc.dart';
// import 'package:cashiru/presentation/bloc/logout/logout_bloc.dart';
// import 'package:cashiru/presentation/bloc/category/category_bloc.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  // Datasources (singleton - satu instance untuk semua)
  getIt.registerLazySingleton<AuthLocalDatasource>(() => AuthLocalDatasource());
  getIt.registerLazySingleton<AuthRemoteDatasource>(() => AuthRemoteDatasource(localDatasource: getIt<AuthLocalDatasource>()));
  getIt.registerLazySingleton<CategoryRemoteDatasource>(() => CategoryRemoteDatasource());
  getIt.registerLazySingleton<ProductRemoteDatasource>(() => ProductRemoteDatasource(localDatasource: getIt<AuthLocalDatasource>()));
  getIt.registerLazySingleton<OrderRemoteDatasource>(() => OrderRemoteDatasource(localDatasource: getIt<AuthLocalDatasource>()));


  // Blocs (factory - instance baru setiap kali dibutuhkan)
  getIt.registerFactory<LoginBloc>(() => LoginBloc(getIt<AuthRemoteDatasource>()));
  getIt.registerFactory<LogoutBloc>(() => LogoutBloc(getIt<AuthRemoteDatasource>()));
  getIt.registerFactory<CategoryBloc>(() => CategoryBloc(getIt<CategoryRemoteDatasource>()));
  getIt.registerFactory<ProductBloc>(() => ProductBloc(getIt<ProductRemoteDatasource>()));
  getIt.registerFactory<CheckoutBloc>(() => CheckoutBloc());
  getIt.registerFactory<OrderBloc>(() => OrderBloc(getIt<OrderRemoteDatasource>()));
}
