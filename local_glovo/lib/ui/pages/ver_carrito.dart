import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_glovo/blocs/carrito/bloc/carrito_bloc.dart';
import 'package:local_glovo/repositories/carrito/carrito_repository.dart';
import 'package:local_glovo/ui/pages/entrega_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerCarrito extends StatefulWidget {
  final CarritoRepository carritoRepository;
  const VerCarrito({super.key, required this.carritoRepository});

  @override
  State<VerCarrito> createState() => _VerCarritoState();
}

class _VerCarritoState extends State<VerCarrito> {
  late CarritoRepository carritoRepository;
  late CarritoBloc _carritoBloc;

  @override
  void initState() {
    super.initState();
    carritoRepository = widget.carritoRepository;
    _carritoBloc = CarritoBloc(carritoRepository);
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _carritoBloc.add(VerCarritoItem());
    });
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
            if (state is CarritoError) {}
          },
          builder: (context, state) {
            if (state is CarritoLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is VerCarritoSucess) {
              return _buildCarritoDetails(state);
            } else if (state is CarritoDeleteSucess) {
              return Center(
                child: Text('Producto eliminado correctamente'),
              );
            } else if (state is CarritoError) {
              return Center(
                child: Text('Tu carrito esta vacio...'),
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

  Widget _buildCarritoDetails(VerCarritoSucess state) {
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

                                bloc.add(CarritoItem(
                                    productoId: state.carrito.lineasCarrito![0]
                                        .producto!.id!));
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

                              bloc.add(CarritoItem(
                                  productoId: state.carrito.lineasCarrito![0]
                                      .producto!.id!));
                            })
                      ],
                    ),
                  ),
                );
              },
            ),
            Stack(
              children: [
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: 366,
                    height: 200,
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
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: 80,
                    height: 60,
                    margin: EdgeInsets.only(left: 19, right: 19, bottom: 14),
                    child: ElevatedButton(
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
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
