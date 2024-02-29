import 'package:flutter/material.dart';
import 'package:local_glovo/blocs/comercio/bloc/comercio_bloc.dart';
import 'package:local_glovo/blocs/comercio/bloc/comercio_details_bloc.dart';
import 'package:local_glovo/blocs/ingredientes/bloc/view_ingredientes_bloc.dart';
import 'package:local_glovo/repositories/carrito/carrito_repository_impl.dart';
import 'package:local_glovo/repositories/comercio/comercio_repository.dart';
import 'package:local_glovo/repositories/comercio/comercio_repository_impl.dart';
import 'package:local_glovo/ui/pages/inicio_sesion.dart';
import 'package:local_glovo/ui/pages/register_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder:
          (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator(); // Muestra un indicador de carga mientras las preferencias compartidas se están cargando
        }

        final prefs = snapshot.data;
        final usuarioId = prefs?.getString('usuarioId') ??
            '5d818565-99f9-4d80-920e-8259c6ecb8e6';
        // Recupera el usuarioId de las preferencias compartidas

        return MultiProvider(
          providers: [
            Provider<ComercioRepositoryImpl>(
              create: (BuildContext context) => ComercioRepositoryImpl(),
            ),
            Provider<ComercioBloc>(
              create: (BuildContext context) =>
                  ComercioBloc(context.read<ComercioRepositoryImpl>()),
              dispose: (_, ComercioBloc bloc) => bloc.close(),
            ),
            Provider<ComercioDetailsBloc>(
              create: (BuildContext context) =>
                  ComercioDetailsBloc(context.read<ComercioRepositoryImpl>()),
            ),
            Provider<ViewIngredientesBloc>(
              create: (BuildContext context) =>
                  ViewIngredientesBloc(context.read<ComercioRepositoryImpl>()),
            ),
          ],
          child: MaterialApp(
            title: 'My App',
            home: RegisterPage(
              usuarioId: usuarioId, // Proporciona el usuarioId a RegisterPage
              carritoRepository: CarritoRepositoryImpl(),
            ),
          ),
        );
      },
    );
  }
}
