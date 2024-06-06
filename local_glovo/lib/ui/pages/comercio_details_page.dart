import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_glovo/blocs/bloc/image_bloc.dart';
import 'package:local_glovo/blocs/carrito/bloc/carrito_bloc.dart';
import 'package:local_glovo/blocs/comercio/bloc/comercio_details_bloc.dart';
import 'package:local_glovo/models/response/comercio_details_response.dart';
import 'package:local_glovo/repositories/carrito/carrito_repository.dart';
import 'package:local_glovo/repositories/carrito/carrito_repository_impl.dart';
import 'package:local_glovo/repositories/comercio/comercio_repository.dart';
import 'package:local_glovo/repositories/comercio/comercio_repository_impl.dart';
import 'package:local_glovo/ui/pages/carrito_page.dart';
import 'package:local_glovo/ui/pages/ingredientes_page.dart';
import 'package:local_glovo/models/response/comercio_response.dart';

class ComercioDetailsPage extends StatefulWidget {
  final String comercioID;
  final CarritoRepository carritoRepository;

  const ComercioDetailsPage(
      {Key? key, required this.comercioID, required this.carritoRepository})
      : super(key: key);

  @override
  State<ComercioDetailsPage> createState() => _ComercioDetailsPageState();
}

class _ComercioDetailsPageState extends State<ComercioDetailsPage> {
  late ComercioRepository comercioRepository;
  late ComercioDetailsBloc _comercioDetailsBloc;
  late List<ImageBloc> _imageBlocs;

  @override
  void initState() {
    super.initState();
    comercioRepository = ComercioRepositoryImpl();
    _comercioDetailsBloc = ComercioDetailsBloc(comercioRepository);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _comercioDetailsBloc.add(
        ComercioDetailsItem(comercioId: widget.comercioID),
      );
    });
  }

  @override
  void dispose() {
    _comercioDetailsBloc.close();
    for (var bloc in _imageBlocs) {
      bloc.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalles del comercio"),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<ComercioDetailsBloc>.value(value: _comercioDetailsBloc),
        ],
        child: BlocConsumer<ComercioDetailsBloc, ComercioDetailsState>(
          buildWhen: (context, state) {
            return state is ComercioDetailsInitial ||
                state is ComercioDetailsSucces ||
                state is ComercioDetailsError ||
                state is ComercioDetailsLoading;
          },
          builder: (context, state) {
            if (state is ComercioDetailsSucces) {
              // Inicializa ImageBlocs aquí después de obtener los productos
              _initializeImageBlocs(state.comercio);
              return _buildComercioDetails(state.comercio);
            } else if (state is ComercioDetailsError) {
              return const Text("Error al cargar los detalles del comercio");
            } else if (state is ComercioDetailsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return const SizedBox.shrink();
          },
          listener: (BuildContext context, ComercioDetailsState state) {},
        ),
      ),
    );
  }

  void _initializeImageBlocs(ComercioDetailsResponse comercio) {
    final totalImages = 1 + (comercio.productos?.length ?? 0);
    _imageBlocs =
        List.generate(totalImages, (index) => ImageBloc(comercioRepository));

    // Add the event for comercio image
    if (comercio.imagen != null) {
      _imageBlocs[0].add(VerImageItem(fileName: comercio.imagen!));
    }

    // Add the events for each product image
    comercio.productos?.asMap().forEach((index, producto) {
      if (producto.imagen != null) {
        _imageBlocs[index + 1].add(VerImageItem(fileName: producto.imagen!));
      }
    });
  }

  Widget _buildComercioDetails(ComercioDetailsResponse? comercio) {
    if (comercio == null) {
      return Container();
    }

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
                    child: BlocBuilder<ImageBloc, ImageState>(
                      bloc: _imageBlocs[0],
                      builder: (context, state) {
                        if (state is ImageLoading) {
                          return CircularProgressIndicator();
                        } else if (state is VerImageSucces) {
                          return Image.memory(
                            state.uint8list1,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 130,
                          );
                        } else if (state is VerImageError) {
                          return Icon(Icons.error);
                        } else {
                          return SizedBox.shrink();
                        }
                      },
                    ),
                  ),
                ),
                ListTile(
                  leading: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[],
                  ),
                  title: Center(child: Text(comercio.name!)),
                  subtitle: Center(child: Text(comercio.nameDirection!)),
                ),
              ],
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: comercio.productos!.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Colors.white,
              elevation: 10,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => IngredientesPage(
                          productos: comercio.productos![index]),
                    ),
                  );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      contentPadding: EdgeInsets.all(10.0),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Container(
                          margin: EdgeInsets.only(right: 8.0),
                          child: BlocBuilder<ImageBloc, ImageState>(
                            bloc: _imageBlocs[index + 1], // Imagen del producto
                            builder: (context, state) {
                              if (state is ImageLoading) {
                                return CircularProgressIndicator();
                              } else if (state is VerImageSucces) {
                                return Image.memory(
                                  state.uint8list1,
                                  fit: BoxFit.cover,
                                  width: 50,
                                  height: 50,
                                );
                              } else if (state is VerImageError) {
                                return Icon(Icons.error);
                              } else {
                                return SizedBox.shrink();
                              }
                            },
                          ),
                        ),
                      ),
                      title:
                          Center(child: Text(comercio.productos![index].name!)),
                      trailing: Container(
                        margin: EdgeInsets.only(top: 8.0),
                        child: Text(
                          "${comercio.productos?[index].precio}€",
                          style: TextStyle(
                            fontSize:
                                20, // Ajusta este valor según tus necesidades
                            fontWeight:
                                FontWeight.bold, // Opcional, para negrita
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          String productoId = comercio.productos![index].id!;

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CarritoPage(
                                productoId: productoId,
                                carritoRepository: widget.carritoRepository,
                              ),
                            ),
                          );
                        },
                        child: const Text('Agregar al carrito',
                            style: TextStyle(fontSize: 20)),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
