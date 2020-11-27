import 'dart:convert';
import 'package:http/http.dart' as http;

class UserRepository {
  UserRepository(this.httpClient);
  final http.Client httpClient;

  Future<String> login(String email, String password) async {
    final response = await httpClient.post("/auth/login", body: {
      "email": email,
      "password": password,
    });

    final data = json.decode(response.body);
    return data["jwt"];
  }
}
