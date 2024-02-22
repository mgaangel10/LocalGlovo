import 'package:http/http.dart';
import 'package:local_glovo/models/dto/login_dto.dart';
import 'package:local_glovo/models/dto/register_dto.dart';
import 'package:local_glovo/models/response/login_response.dart';
import 'package:local_glovo/models/response/register_response.dart';
import 'package:local_glovo/repositories/auth/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositoryImpl extends AuthRepository {
  final Client _httpClient = Client();

  @override
  Future<LoginResponse> login(LoginDto loginDto) async {
    final response = await _httpClient.post(
      Uri.parse('http://localhost:9000/auth/login/user'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'accept': 'application/json',
      },
      body: loginDto.toJson(),
    );
    if (response.statusCode == 201) {
      return LoginResponse.fromJson(response.body);
    } else {
      throw Exception('Fail to login');
    }
  }

  @override
  Future<RegisterResponse> register(RegisterDto registerDto) async {
    final response = await _httpClient.post(
      Uri.parse('http://localhost:9000/auth/register/user'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: registerDto.toJson(),
    );
    if (response.statusCode == 201) {
      return RegisterResponse.fromJson(response.body);
    } else {
      throw Exception('Fail to register');
    }
  }
}
