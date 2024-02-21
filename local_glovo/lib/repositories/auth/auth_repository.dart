import 'package:local_glovo/models/dto/login_dto.dart';
import 'package:local_glovo/models/response/login_response.dart';

abstract class AuthRepository {
  Future<LoginResponse> login(LoginDto loginDto);
}
