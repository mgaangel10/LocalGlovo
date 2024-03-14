import 'package:flutter/material.dart';
import 'package:local_glovo/blocs/carrito/bloc/carrito_bloc.dart';
import 'package:local_glovo/blocs/comercio/bloc/comercio_bloc.dart';
import 'package:local_glovo/blocs/comercio/bloc/comercio_details_bloc.dart';
import 'package:local_glovo/blocs/ingredientes/bloc/view_ingredientes_bloc.dart';
import 'package:local_glovo/blocs/valoracion/bloc/valoracion_bloc.dart';
import 'package:local_glovo/repositories/carrito/carrito_repository_impl.dart';
import 'package:local_glovo/repositories/comercio/comercio_repository.dart';
import 'package:local_glovo/repositories/comercio/comercio_repository_impl.dart';
import 'package:local_glovo/repositories/valoracion/valoracion_repository_impl.dart';
import 'package:local_glovo/ui/pages/inicio_sesion.dart';
import 'package:local_glovo/ui/pages/register_page.dart';
import 'package:local_glovo/ui/widget/geocalizacion.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
        Provider<ValoracionBloc>(
          create: (BuildContext context) {
            return ValoracionBloc(
              context.read<ValoracioRespositoryImpl>(),
            );
          },
          dispose: (_, ValoracionBloc bloc) => bloc.close(),
        ),
        Provider<ValoracioRespositoryImpl>(
          create: (BuildContext context) => ValoracioRespositoryImpl(),
        ),
        Provider<ValoracionBloc>(
          create: (BuildContext context) {
            final repository = context.read<ValoracioRespositoryImpl>();
            return ValoracionBloc(repository);
          },
          dispose: (_, ValoracionBloc bloc) => bloc.close(),
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
