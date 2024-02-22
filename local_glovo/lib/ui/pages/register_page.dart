import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_glovo/blocs/register/bloc/register_bloc.dart';
import 'package:local_glovo/repositories/auth/auth_repository.dart';
import 'package:local_glovo/repositories/auth/auth_repository_impl.dart';
import 'package:local_glovo/ui/pages/inicio_sesion.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formRegister = GlobalKey<FormState>();
  final emailTextController = TextEditingController();
  final nameTextController = TextEditingController();
  final lastnameTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final birthDateTextController = TextEditingController();
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
    birthDateTextController.dispose();
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
              return const Text("Error de registro");
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
                MaterialPageRoute(builder: (context) => InicioSesion()),
              );
            }
          },
        ),
      ),
    );
  }

  _buildRegisterForm() {
    return Padding(
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
                          ? Icon(Icons.check_circle, color: Colors.green)
                          : null,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor introduce el correo electrónico';
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
                    'Fecha de nacimiento',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextFormField(
                    controller: birthDateTextController,
                    decoration: InputDecoration(
                      hintText: 'DD/MM/YYYY',
                      suffixIcon: birthDateTextController.text.isNotEmpty
                          ? Icon(Icons.check_circle, color: Colors.green)
                          : null,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor introduce tu fecha de nacimiento';
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
                              birthDateTextController.text,
                            ));
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
                                builder: (context) => InicioSesion()),
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
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  icon: Image.network(
                    'https://th.bing.com/th/id/R.8af6752066ab4e5c10d3b07502b9a560?rik=4IL1%2bSsxAuCETg&pid=ImgRaw&r=0',
                    height: 18.0,
                    width: 18.0,
                  ),
                  label: Text(
                    'Registro con Google'.toUpperCase(),
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
