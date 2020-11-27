import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import 'package:testing/user_repository.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  test("UserRepository.login restituisce correttamente la jwt dell'utente loggato", () async {
    final httpClient = MockHttpClient();

    final email = "user@email.com";
    final password = "password";

    when(httpClient.post("/auth/login", body: {
      "email": email,
      "password": password,
    })).thenAnswer((realInvocation) async => http.Response('{"jwt": "JWT_TOKEN"}', 200));

    final userRepository = UserRepository(httpClient);
    final jwt = await userRepository.login(email, password);

    expect(jwt, "JWT_TOKEN");
  });
}
