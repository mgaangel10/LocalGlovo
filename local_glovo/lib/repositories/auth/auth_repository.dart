import 'package:local_glovo/models/dto/login_dto.dart';
import 'package:local_glovo/models/dto/register_dto.dart';
import 'package:local_glovo/models/response/detalles_usuario_response.dart';
import 'package:local_glovo/models/response/login_response.dart';
import 'package:local_glovo/models/response/register_response.dart';

abstract class AuthRepository {
  Future<LoginResponse> login(LoginDto loginDto);
  Future<RegisterResponse> register(RegisterDto registerDto);
  Future<DetallesUsuarioResponse> verPerfil();
}
