import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_glovo/blocs/login/bloc/login_bloc.dart';
import 'package:local_glovo/repositories/auth/auth_repository.dart';
import 'package:local_glovo/repositories/auth/auth_repository_impl.dart';
import 'package:local_glovo/repositories/carrito/carrito_repository.dart';
import 'package:local_glovo/ui/pages/favorito_page.dart';
import 'package:local_glovo/ui/pages/ver_favorito_page.dart';

class UserPage extends StatefulWidget {
  final CarritoRepository carritoRepository;
  const UserPage({super.key, required this.carritoRepository});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late AuthRepository authRepository;
  late LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    authRepository = AuthRepositoryImpl();
    _loginBloc = LoginBloc(authRepository);
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _loginBloc.add(DetallesUsuarioItem());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        automaticallyImplyLeading: false,
      ),
      body: BlocProvider.value(
        value: _loginBloc,
        child: BlocConsumer<LoginBloc, LoginState>(
          buildWhen: (context, state) {
            return state is LoginInitial ||
                state is DetallesUsuarioSucess ||
                state is DoLoginError ||
                state is DoLoginLoading;
          },
          builder: (context, state) {
            if (state is DetallesUsuarioSucess) {
              return _buildDetallesUsuario();
            } else if (state is DoLoginError) {
              return const Text("error al cargar los detalles del usuario");
            } else if (state is DoLoginLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Center(child: _buildDetallesUsuario());
          },
          listener: (BuildContext context, LoginState state) {},
        ),
      ),
    );
  }

  Widget _buildDetallesUsuario() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      if (state is DetallesUsuarioSucess) {
        final detalles = state.registerResponse;
        return ListView(
          children: <Widget>[
            Center(
              child: Card(
                surfaceTintColor: Colors.white,
                margin: EdgeInsets.all(8.0),
                color: Colors.white,
                elevation: 10,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Column(
                          children: <Widget>[
                            Text(
                              'Nombre',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                            Text(
                              'Apellidos',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                            Text(
                              'Nombre usuario',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                            Text(
                              'Telefono',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              detalles.name!,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                            Text(
                              detalles.lastName!,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                            Text(
                              detalles.username!,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                            Text(
                              detalles.phoneNumber!,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Card(
                surfaceTintColor: Colors.white,
                margin: EdgeInsets.all(8.0),
                color: Colors.white,
                elevation: 10,
                child: Column(
                  children: <Widget>[
                    Container(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => VerFavoritoPage(
                                            carritoRepository:
                                                widget.carritoRepository,
                                          )),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    'Ver Tu lista de favoritos',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Icon(
                                    Icons.favorite,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      } else {
        return Container();
      }
    });
  }
}
