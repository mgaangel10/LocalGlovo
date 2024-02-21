import 'package:http/http.dart';
import 'package:local_glovo/models/dto/login_dto.dart';
import 'package:local_glovo/models/response/login_response.dart';
import 'package:local_glovo/repositories/auth/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final Client _httpClient = Client();

  @override
  Future<LoginResponse> login(LoginDto loginDto) async {
    final response = await _httpClient.post(
      Uri.parse('http://localhost:9000/auth/login/user'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: loginDto.toJson(),
    );
    if (response.statusCode == 201) {
      return LoginResponse.fromJson(response.body);
    } else {
      throw Exception('Fail to login');
    }
  }
}
