import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_glovo/blocs/bloc/image_bloc.dart';
import 'package:local_glovo/blocs/carrito/bloc/carrito_bloc.dart';
import 'package:local_glovo/repositories/carrito/carrito_repository.dart';
import 'package:local_glovo/repositories/comercio/comercio_repository_impl.dart';
import 'package:local_glovo/ui/pages/entrega_page.dart';
import 'package:local_glovo/models/response/add_producto_to_cart/add_producto_to_cart.dart';
import 'package:local_glovo/models/response/add_producto_to_cart/lineas_carrito.dart';

class CarritoPage extends StatefulWidget {
  final CarritoRepository carritoRepository;
  final String productoId;
  const CarritoPage(
      {Key? key, required this.carritoRepository, required this.productoId})
      : super(key: key);

  @override
  State<CarritoPage> createState() => _CarritoPageState();
}

class _CarritoPageState extends State<CarritoPage> {
  late CarritoRepository carritoRepository;
  late CarritoBloc _carritoBloc;
  late List<ImageBloc> _imageBlocs;

  @override
  void initState() {
    super.initState();
    carritoRepository = widget.carritoRepository;
    _carritoBloc = CarritoBloc(carritoRepository);
    _imageBlocs = [];

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _carritoBloc.add(CarritoItem(productoId: widget.productoId));
    });
  }

  @override
  void dispose() {
    _carritoBloc.close();
    for (var bloc in _imageBlocs) {
      bloc.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi carrito'),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _carritoBloc),
        ],
        child: BlocConsumer<CarritoBloc, CarritoState>(
          listener: (context, state) {
            if (state is CarritoError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Ha ocurrido un error: ${state.error}')),
              );
            }
          },
          builder: (context, state) {
            if (state is CarritoLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is CarritoSucces) {
              _initializeImageBlocs(state.carrito.lineasCarrito);
              return _buildCarritoDetails(state);
            } else if (state is CarritoDeleteSucess) {
              return Center(
                child: Text('Producto eliminado correctamente'),
              );
            } else if (state is CarritoError) {
              return Center(
                child: Text('Ha ocurrido un error: ${state.error}'),
              );
            } else {
              return Center(
                child: Text('Estado desconocido'),
              );
            }
          },
        ),
      ),
    );
  }

  void _initializeImageBlocs(List<LineasCarrito>? lineasCarrito) {
    _imageBlocs = List.generate(
      lineasCarrito?.length ?? 0,
      (index) => ImageBloc(ComercioRepositoryImpl()),
    );

    for (int i = 0; i < lineasCarrito!.length; i++) {
      if (lineasCarrito[i].producto!.imagen != null) {
        _imageBlocs[i]
            .add(VerImageItem(fileName: lineasCarrito[i].producto!.imagen!));
      }
    }
  }

  Widget _buildCarritoDetails(CarritoSucces state) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: state.carrito.lineasCarrito?.length ?? 0,
                itemBuilder: (context, index) {
                  final lineaCarrito = state.carrito.lineasCarrito![index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      leading: BlocBuilder<ImageBloc, ImageState>(
                        bloc: _imageBlocs[index],
                        builder: (context, state) {
                          if (state is ImageLoading) {
                            return CircularProgressIndicator();
                          } else if (state is VerImageSucces) {
                            return Image.memory(state.uint8list1,
                                fit: BoxFit.cover, width: 50, height: 50);
                          } else if (state is VerImageError) {
                            return Icon(Icons.error);
                          } else {
                            return Container();
                          }
                        },
                      ),
                      title: Text(lineaCarrito.producto!.name!,
                          style: TextStyle(fontSize: 18)),
                      subtitle: Text(
                          '${lineaCarrito.producto!.precio.toString()}€',
                          style: TextStyle(fontSize: 16)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Material(
                              elevation: 10.0,
                              child: TextButton(
                                onPressed: () {
                                  final bloc = context.read<CarritoBloc>();
                                  bloc.add(CArritoDeleteItem(
                                    carritoId: state.carrito.id!,
                                    productoId: lineaCarrito.producto!.id!,
                                  ));

                                  bloc.add(CarritoItem(
                                      productoId: widget.productoId));
                                },
                                child: Text('x${lineaCarrito.cantidad!}',
                                    style: TextStyle(color: Colors.black)),
                              ),
                            ),
                          ),
                          IconButton(
                            iconSize: 30,
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              final bloc = context.read<CarritoBloc>();
                              bloc.add(CArritoDeleteItem(
                                carritoId: state.carrito.id!,
                                productoId: lineaCarrito.producto!.id!,
                              ));
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              width: double.infinity,
              height: 200,
              padding: EdgeInsets.all(16),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: const Color.fromARGB(255, 248, 248, 248),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total:",
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          state.carrito.total.toString() + "€",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EntregaPage(
                              carritoId: state.carrito.id!,
                            ),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(width: 8),
                          Text(
                            'Proceder a pago',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          Icon(Icons.shopping_cart, color: Colors.white),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
