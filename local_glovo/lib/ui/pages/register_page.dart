import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_glovo/blocs/register/bloc/register_bloc.dart';
import 'package:local_glovo/repositories/auth/auth_repository.dart';
import 'package:local_glovo/repositories/auth/auth_repository_impl.dart';
import 'package:local_glovo/repositories/carrito/carrito_repository.dart';
import 'package:local_glovo/ui/pages/Email_existente_error.dart';
import 'package:local_glovo/ui/pages/error_page.dart';
import 'package:local_glovo/ui/pages/inicio_sesion.dart';

class RegisterPage extends StatefulWidget {
  final CarritoRepository carritoRepository;
  const RegisterPage({super.key, required this.carritoRepository});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formRegister = GlobalKey<FormState>();
  final emailTextController = TextEditingController();
  final nameTextController = TextEditingController();
  final lastnameTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final phoneNumber = TextEditingController();

  late AuthRepository authRepository;
  late RegisterBloc _registerBloc;

  @override
  void initState() {
    authRepository = AuthRepositoryImpl();
    _registerBloc = RegisterBloc(authRepository);
    super.initState();
  }

  @override
  void dispose() {
    emailTextController.dispose();
    nameTextController.dispose();
    lastnameTextController.dispose();
    passwordTextController.dispose();
    phoneNumber.dispose();

    _registerBloc.close();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider.value(
        value: _registerBloc,
        child: BlocConsumer<RegisterBloc, RegisterState>(
          buildWhen: (context, state) {
            return state is RegisterInitial ||
                state is DoRegisterSuccess ||
                state is DoRegisterError ||
                state is DoRegisterLoading;
          },
          builder: (context, state) {
            if (state is DoRegisterSuccess) {
              return const Text("Registro exitoso");
            } else if (state is DoRegisterError) {
              return Center(
                  child: ErrorEmailExistente(
                carritoRepository: widget.carritoRepository,
                errorMessage: state.errorMessage,
              ));
            } else if (state is DoRegisterLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Center(child: _buildRegisterForm());
          },
          listener: (BuildContext context, RegisterState state) {
            if (state is DoRegisterSuccess) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InicioSesion(
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

  _buildRegisterForm() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formRegister,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Icon(
                    Icons.person_add,
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
                      'Nombre',
                      style: TextStyle(fontSize: 16),
                    ),
                    TextFormField(
                      controller: nameTextController,
                      decoration: InputDecoration(
                        hintText: 'Introduce tu nombre',
                        suffixIcon: nameTextController.text.isNotEmpty
                            ? Icon(Icons.check_circle, color: Colors.green)
                            : null,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor introduce tu nombre';
                        }
                        if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                          return 'El campo nombre solo puede contener letras';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Apellido',
                      style: TextStyle(fontSize: 16),
                    ),
                    TextFormField(
                      controller: lastnameTextController,
                      decoration: InputDecoration(
                        hintText: 'Introduce tu apellido',
                        suffixIcon: lastnameTextController.text.isNotEmpty
                            ? Icon(Icons.check_circle, color: Colors.green)
                            : null,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor introduce tu apellido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Correo electrónico',
                      style: TextStyle(fontSize: 16),
                    ),
                    TextFormField(
                      controller: emailTextController,
                      decoration: InputDecoration(
                        hintText: 'example@gmail.com',
                        suffixIcon: emailTextController.text.isNotEmpty
                            ? Icon(Icons.cancel,
                                color: Color.fromARGB(255, 250, 0, 0))
                            : null,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor introduce el correo electrónico';
                        }
                        if (DoRegisterError ==
                            "El email ya ha sido registrado") {
                          return "hola";
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
                      controller: passwordTextController,
                      obscureText: true,
                      decoration: InputDecoration(
                        suffixIcon: passwordTextController.text.isNotEmpty
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
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Numero de telefono',
                      style: TextStyle(fontSize: 16),
                    ),
                    TextFormField(
                      controller: phoneNumber,
                      decoration: InputDecoration(
                        hintText: 'Itruce su numero de telefono',
                        suffixIcon: nameTextController.text.isNotEmpty
                            ? Icon(Icons.check_circle, color: Colors.green)
                            : null,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Porfavor introduce su numero de telfono';
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
                            'Registro'.toUpperCase(),
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            if (_formRegister.currentState!.validate()) {
                              _registerBloc.add(DoRegisterEvent(
                                  emailTextController.text,
                                  nameTextController.text,
                                  lastnameTextController.text,
                                  passwordTextController.text,
                                  phoneNumber.text));
                            }
                          },
                        ),
                      ),
                    ),
                  ),
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
                            'Ya tienes cuenta?'.toUpperCase(),
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => InicioSesion(
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
