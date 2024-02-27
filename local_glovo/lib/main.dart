import 'package:flutter/material.dart';
import 'package:local_glovo/blocs/comercio/bloc/comercio_bloc.dart';
import 'package:local_glovo/blocs/comercio/bloc/comercio_details_bloc.dart';
import 'package:local_glovo/blocs/ingredientes/bloc/view_ingredientes_bloc.dart';
import 'package:local_glovo/repositories/comercio/comercio_repository.dart';
import 'package:local_glovo/repositories/comercio/comercio_repository_impl.dart';
import 'package:local_glovo/ui/pages/inicio_sesion.dart';
import 'package:local_glovo/ui/pages/register_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
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
        home: const RegisterPage(),
      ),
    );
  }
}
