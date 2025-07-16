import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:cashiru/data/datasource/auth_remote_datasource.dart';
import 'package:cashiru/data/datasource/auth_local_datasource.dart';
import 'package:cashiru/data/models/response/auth_response_model.dart';
import 'package:cashiru/core/constants/variables.dart';

// * Code version 1 - Mockito
import 'auth_remote_datasource_test.mocks.dart';

@GenerateMocks([http.Client, AuthLocalDatasource])
void main() {
  late AuthRemoteDatasource datasource;
  late MockClient mockHttp;
  late MockAuthLocalDatasource mockLocal;

  setUp(() {
    mockHttp = MockClient();
    mockLocal = MockAuthLocalDatasource();
    Variables.httpClient = mockHttp;
    datasource = AuthRemoteDatasource();
  });

  group('login', () {
    test('returns Right(AuthResponseModel) on 200', () async {
      final responseJson = jsonEncode({
        "message": "ok",
        "token": "abc",
        "user": {"id": 1, "name": "Test"},
      });

      when(mockHttp.post(
        any,
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response(responseJson, 200));

      final result = await datasource.login('admin@mail.com', '1234');

      expect(result.isRight(), true);
      expect(result.getOrElse(() => throw 'err').token.runtimeType, String);
    });
  });
}

// * Code version 2 - Mocktail
// import 'package:mocktail/mocktail.dart';
// class MockHttpClient extends Mock implements http.Client {}
// class MockAuthLocalDatasource extends Mock implements AuthLocalDatasource {}

// void main() {
//   late AuthRemoteDatasource datasource;
//   late MockHttpClient mockHttp;
//   late MockAuthLocalDatasource mockLocal;

//   setUpAll(() {
//     // Register fallback values for mocktail
//     registerFallbackValue(Uri.parse('https://example.com'));
//   });

//   setUp(() {
//     mockHttp = MockHttpClient();
//     mockLocal = MockAuthLocalDatasource();
//     Variables.httpClient = mockHttp;
//     datasource = AuthRemoteDatasource();
//   });

//   group('login', () {
//     test('returns Right(AuthResponseModel) on 200', () async {
//       final responseJson = jsonEncode({
//         "message": "ok",
//         "token": "abc",
//         "user": {"id": 1, "name": "Test"},
//       });

//       when(() => mockHttp.post(
//         any(),
//         headers: any(named: 'headers'),
//         body: any(named: 'body'),
//       )).thenAnswer((_) async => http.Response(responseJson, 200));

//       final result = await datasource.login('admin@mail.com', '134');
//       expect(result.isRight(), true);
//       expect(result.getOrElse(() => throw 'err').token.runtimeType, String);
      
//     });
//   });
// }