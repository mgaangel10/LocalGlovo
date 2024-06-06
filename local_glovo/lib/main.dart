import 'package:flutter/material.dart';
import 'package:local_glovo/blocs/bloc/image_bloc.dart';
import 'package:local_glovo/blocs/carrito/bloc/carrito_bloc.dart';
import 'package:local_glovo/blocs/comercio/bloc/comercio_bloc.dart';
import 'package:local_glovo/blocs/comercio/bloc/comercio_details_bloc.dart';
import 'package:local_glovo/blocs/ingredientes/bloc/view_ingredientes_bloc.dart';
import 'package:local_glovo/repositories/carrito/carrito_repository_impl.dart';
import 'package:local_glovo/repositories/comercio/comercio_repository.dart';
import 'package:local_glovo/repositories/comercio/comercio_repository_impl.dart';
import 'package:local_glovo/ui/pages/inicio_sesion.dart';
import 'package:local_glovo/ui/pages/register_page.dart';
import 'package:local_glovo/ui/widget/comercio_list.dart';
import 'package:local_glovo/ui/widget/geocalizacion.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ComercioBloc>(
          create: (BuildContext context) =>
              ComercioBloc(context.read<ComercioRepositoryImpl>()),
          dispose: (_, ComercioBloc bloc) => bloc.close(),
        ),
        Provider<ImageBloc>(
          create: (BuildContext context) =>
              ImageBloc(context.read<ComercioRepositoryImpl>()),
          dispose: (_, ImageBloc bloc) => bloc.close(),
        ),
      ],
      child: MaterialApp(
        title: 'My App',
        home: RegisterPage(
          carritoRepository: CarritoRepositoryImpl(),
        ),
      ),
    );
  }
}
