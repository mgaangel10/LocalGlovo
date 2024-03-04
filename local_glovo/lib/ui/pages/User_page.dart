import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_glovo/blocs/login/bloc/login_bloc.dart';
import 'package:local_glovo/repositories/auth/auth_repository.dart';
import 'package:local_glovo/repositories/auth/auth_repository_impl.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

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
        title: Text("user"),
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
                margin: EdgeInsets.all(8.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Colors.white,
                elevation: 10,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 8.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Text(detalles.name!)),
                    ),
                    ListTile(
                      leading: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(Icons.star, size: 24),
                          Text("${detalles.lastName!}")
                        ],
                      ),
                      title:
                          Center(child: Text(detalles.phoneNumber.toString())),
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
