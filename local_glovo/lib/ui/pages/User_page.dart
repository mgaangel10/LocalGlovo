import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_glovo/blocs/login/bloc/login_bloc.dart';
import 'package:local_glovo/repositories/auth/auth_repository.dart';
import 'package:local_glovo/repositories/auth/auth_repository_impl.dart';
import 'package:local_glovo/repositories/carrito/carrito_repository.dart';
import 'package:local_glovo/ui/pages/favorito_page.dart';
import 'package:local_glovo/ui/pages/inicio_sesion.dart';
import 'package:local_glovo/ui/pages/ver_favorito_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        title: Text(
          "Perfil",
        ),
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
              return const Center(
                child: Text("Error al cargar los detalles del usuario",
                    style: TextStyle(fontSize: 18)),
              );
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
            Card(
              margin: EdgeInsets.all(16.0),
              color: Colors.white,
              elevation: 10,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Detalles del Usuario',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    ListTile(
                      leading: Icon(Icons.person),
                      title: Text('Nombre'),
                      subtitle: Text(detalles.name!),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.person_outline),
                      title: Text('Apellidos'),
                      subtitle: Text(detalles.lastName!),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.account_circle),
                      title: Text('Nombre usuario'),
                      subtitle: Text(detalles.username!),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.phone),
                      title: Text('Telefono'),
                      subtitle: Text(detalles.phoneNumber!),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(16.0),
              color: Colors.white,
              elevation: 10,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VerFavoritoPage(
                                    carritoRepository: widget.carritoRepository,
                                  )),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Ver Tu lista de favoritos',
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.favorite)
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        await removeToken();

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InicioSesion(
                              carritoRepository: widget.carritoRepository,
                            ),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Cerrar Sesión',
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.logout)
                        ],
                      ),
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

  Future<void> removeToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
}
