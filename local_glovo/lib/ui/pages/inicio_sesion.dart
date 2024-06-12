import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_glovo/blocs/login/bloc/login_bloc.dart';
import 'package:local_glovo/repositories/auth/auth_repository.dart';
import 'package:local_glovo/repositories/auth/auth_repository_impl.dart';
import 'package:local_glovo/repositories/carrito/carrito_repository.dart';
import 'package:local_glovo/ui/pages/Email_existente_error.dart';
import 'package:local_glovo/ui/pages/error_page.dart';
import 'package:local_glovo/ui/pages/home_page.dart';
import 'package:local_glovo/ui/pages/inicio_page.dart';
import 'package:local_glovo/ui/pages/register_page.dart';

class InicioSesion extends StatefulWidget {
  final CarritoRepository carritoRepository;
  const InicioSesion({super.key, required this.carritoRepository});

  @override
  State<InicioSesion> createState() => _InicioSesionState();
}

class _InicioSesionState extends State<InicioSesion> {
  final _formLogin = GlobalKey<FormState>();
  final userTextController = TextEditingController();
  final passTextController = TextEditingController();

  late AuthRepository authRepository;

  late LoginBloc _loginBloc;

  @override
  void initState() {
    authRepository = AuthRepositoryImpl();
    _loginBloc = LoginBloc(authRepository);
    super.initState();
  }

  @override
  void dispose() {
    userTextController.dispose();
    passTextController.dispose();
    _loginBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider.value(
        value: _loginBloc,
        child: BlocConsumer<LoginBloc, LoginState>(
          buildWhen: (context, state) {
            return state is LoginInitial ||
                state is DoLoginSucces ||
                state is DoLoginError ||
                state is DoLoginLoading;
          },
          builder: (context, state) {
            if (state is DoLoginSucces) {
              return const Text("login succes");
            } else if (state is DoLoginError) {
              return Center(
                  child: ErrorEmailExistente(
                carritoRepository: widget.carritoRepository,
                errorMessage: state.errorMensaje,
              ));
            } else if (state is DoLoginLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Center(child: _buildLoginForm());
          },
          listener: (BuildContext conext, LoginState state) {
            if (state is DoLoginSucces) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InicioPage(
                    carritoRepository: widget.carritoRepository,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  _buildLoginForm() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formLogin,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Icon(
                    Icons.home,
                    size: 100,
                    color: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Correo electronico',
                      style: TextStyle(fontSize: 16),
                    ),
                    TextFormField(
                      controller: userTextController,
                      decoration: InputDecoration(
                        hintText: 'example@gmail.com',
                        suffixIcon: userTextController.text.isNotEmpty
                            ? Icon(Icons.check_circle, color: Colors.green)
                            : null,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor introduce el correo electronico';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Contraseña',
                      style: TextStyle(fontSize: 16),
                    ),
                    TextFormField(
                      controller: passTextController,
                      obscureText: true,
                      decoration: InputDecoration(
                        suffixIcon: passTextController.text.isNotEmpty
                            ? Icon(Icons.check_circle, color: Colors.green)
                            : null,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor introduce la contraseña';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 5,
                              blurRadius: 8,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text(
                            'Inicio sesion'.toUpperCase(),
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            if (_formLogin.currentState!.validate()) {
                              _loginBloc.add(DoLoginEvent(
                                userTextController.text,
                                passTextController.text,
                              ));
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 5,
                              blurRadius: 8,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text(
                            'Registro'.toUpperCase(),
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterPage(
                                  carritoRepository: widget.carritoRepository,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 8,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
