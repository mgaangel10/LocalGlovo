import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_glovo/blocs/comercio/bloc/comercio_bloc.dart';
import 'package:local_glovo/blocs/comercio/bloc/comercio_details_bloc.dart';
import 'package:local_glovo/repositories/carrito/carrito_repository.dart';
import 'package:local_glovo/repositories/comercio/comercio_repository.dart';
import 'package:local_glovo/repositories/comercio/comercio_repository_impl.dart';
import 'package:local_glovo/ui/pages/comercio_details_page.dart';
import 'package:local_glovo/ui/widget/comercio_list.dart';

class ComercioCategorias extends StatefulWidget {
  final CarritoRepository carritoRepository;
  final String categorias;
  const ComercioCategorias(
      {super.key, required this.categorias, required this.carritoRepository});

  @override
  State<ComercioCategorias> createState() => _ComercioCategoriasState();
}

class _ComercioCategoriasState extends State<ComercioCategorias> {
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
              return _buildComercioCategorias();
            } else if (state is ComercioError) {
              return const Text("error al cargar categorias");
            } else if (state is ComercioLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Center(child: _buildComercioCategorias());
          },
          listener: (BuildContext context, ComercioState state) {},
        ),
      ),
    );
  }

  Widget _buildComercioCategorias() {
    return BlocBuilder<ComercioBloc, ComercioState>(builder: (context, state) {
      if (state is ComercioCategoriaSucess) {
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: state.categorias.length,
          itemBuilder: (context, index) {
            final c = state.categorias[index];
            return GestureDetector(
              onTap: () {
                final comercioRepositorio = ComercioRepositoryImpl();
                final detallesCoemercio =
                    ComercioDetailsBloc(comercioRepository);
                detallesCoemercio.add(ComercioDetailsItem(comercioId: c.id!));
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider.value(
                      value: detallesCoemercio,
                      child: ComercioDetailsPage(
                        comercioID: c.id!,
                        carritoRepository: widget.carritoRepository,
                      ),
                    ),
                  ),
                );
              },
              child: ComercioWidget(
                  contentElement: c,
                  carritoRepository: widget.carritoRepository),
            );
          },
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
