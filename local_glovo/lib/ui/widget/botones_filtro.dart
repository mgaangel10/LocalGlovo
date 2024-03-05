import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_glovo/blocs/comercio/bloc/comercio_bloc.dart';
import 'package:local_glovo/repositories/carrito/carrito_repository.dart';
import 'package:local_glovo/repositories/comercio/comercio_repository.dart';
import 'package:local_glovo/repositories/comercio/comercio_repository_impl.dart';

class BotonesFiltro extends StatefulWidget {
  final CarritoRepository carritoRepository;
  final String categorias;
  const BotonesFiltro(
      {super.key, required this.carritoRepository, required this.categorias});

  @override
  State<BotonesFiltro> createState() => _BotonesFiltroState();
}

class _BotonesFiltroState extends State<BotonesFiltro> {
  late ComercioRepository comercioRepository;
  late ComercioBloc _comercioBloc;

  @override
  void initState() {
    super.initState();
    comercioRepository = ComercioRepositoryImpl();
    _comercioBloc = ComercioBloc(comercioRepository);
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _comercioBloc.add(ComercioCategoriasItem(categorias: widget.categorias));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("filtrado"),
      ),
      body: BlocProvider.value(
        value: _comercioBloc,
        child: BlocConsumer<ComercioBloc, ComercioState>(
          buildWhen: (context, state) {
            return state is ComercioInitial ||
                state is ComercioCategoriaSucess ||
                state is ComercioError ||
                state is ComercioLoading;
          },
          builder: (context, state) {
            if (state is ComercioCategoriaSucess) {
              return _buildBotones();
            } else if (state is ComercioError) {
              return const Text("error al cargar categorias");
            } else if (state is ComercioLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Center(child: _buildBotones());
          },
          listener: (BuildContext context, ComercioState state) {},
        ),
      ),
    );
  }

  Widget _buildBotones() {
    return BlocBuilder<ComercioBloc, ComercioState>(builder: (context, state) {
      if (state is ComercioCategoriaSucess) {
        return Container(
          height: 50,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Row(
                  children: [Text(state.categorias[0].categorias!)],
                ),
              )
            ],
          ),
        );
      } else if (state is ComercioError) {
        return Text(state.errorMensaje);
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }
}
