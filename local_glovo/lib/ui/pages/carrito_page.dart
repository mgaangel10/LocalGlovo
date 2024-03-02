import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_glovo/blocs/carrito/bloc/carrito_bloc.dart';
import 'package:local_glovo/models/response/add_producto_to_cart/add_producto_to_cart.dart';
import 'package:local_glovo/repositories/carrito/carrito_repository.dart';
import 'package:local_glovo/repositories/carrito/carrito_repository_impl.dart';

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

  @override
  void initState() {
    super.initState();
    carritoRepository = widget.carritoRepository;
    _carritoBloc = CarritoBloc(carritoRepository);
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _carritoBloc.add(CarritoItem(productoId: widget.productoId));
    });
  }

  @override
  void dispose() {
    _carritoBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi carrito'),
      ),
      body: BlocProvider.value(
        value: _carritoBloc,
        child: BlocConsumer<CarritoBloc, CarritoState>(
          listener: (context, state) {
            if (state is CarritoError) {
              // Maneja el error aquí si es necesario
            }
          },
          builder: (context, state) {
            if (state is CarritoLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is CarritoSucces) {
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

  Widget _buildCarritoDetails(CarritoSucces state) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Stack(
          children: [
            ListView.builder(
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
                    leading: Image.network(lineaCarrito.producto!.imagen!,
                        fit: BoxFit.cover),
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
                                // Añade un evento para cargar los detalles del carrito después de eliminar el producto
                                bloc.add(
                                    CarritoItem(productoId: widget.productoId));
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
                              // Añade un evento para cargar los detalles del carrito después de eliminar el producto
                              bloc.add(
                                  CarritoItem(productoId: widget.productoId));
                            })
                      ],
                    ),
                  ),
                );
              },
            ),
            Positioned(
              top: constraints.maxHeight / 2 - 50,
              left: 0,
              right: 0,
              child: Container(
                width: 366,
                height: 71,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: const Color.fromARGB(255, 248, 248, 248),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          "Total:",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          state.carrito.total.toString() + "€",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: constraints.maxHeight / 2 + 58,
              left: 0,
              right: 0,
              child: Container(
                width: 150,
                height: 68,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                  ),
                  onPressed: () {},
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(width: 8),
                      Text('Proceder a pago',
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                      Icon(Icons.shopping_cart, color: Colors.white),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
