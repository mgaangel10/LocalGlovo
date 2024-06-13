import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_glovo/blocs/bloc/image_bloc.dart';
import 'package:local_glovo/blocs/carrito/bloc/carrito_bloc.dart';
import 'package:local_glovo/models/response/add_producto_to_cart/add_producto_to_cart.dart';
import 'package:local_glovo/repositories/carrito/carrito_repository.dart';
import 'package:local_glovo/repositories/comercio/comercio_repository.dart';
import 'package:local_glovo/repositories/comercio/comercio_repository_impl.dart';
import 'package:local_glovo/ui/pages/carrito_page.dart';
import 'package:local_glovo/ui/pages/entrega_page.dart';

class VerCarrito extends StatefulWidget {
  final CarritoRepository carritoRepository;
  const VerCarrito({super.key, required this.carritoRepository});

  @override
  State<VerCarrito> createState() => _VerCarritoState();
}

class _VerCarritoState extends State<VerCarrito> {
  late CarritoRepository carritoRepository;
  late CarritoBloc _carritoBloc;
  late ComercioRepository comercioRepository;
  late List<ImageBloc> _imageBlocs;
  @override
  void initState() {
    super.initState();
    carritoRepository = widget.carritoRepository;
    comercioRepository = ComercioRepositoryImpl();
    _carritoBloc = CarritoBloc(carritoRepository);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _carritoBloc.add(VerCarritoItem(context, carritoRepository));
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

  void _initializeImageBlocs(AddProductoToCart carrito) {
    _imageBlocs = List.generate(carrito.lineasCarrito?.length ?? 0,
        (index) => ImageBloc(comercioRepository));

    carrito.lineasCarrito?.asMap().forEach((index, lineaCarrito) {
      if (lineaCarrito.producto?.imagen != null) {
        _imageBlocs[index]
            .add(VerImageItem(fileName: lineaCarrito.producto!.imagen!));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi carrito'),
        automaticallyImplyLeading: false,
      ),
      body: BlocProvider.value(
        value: _carritoBloc,
        child: BlocConsumer<CarritoBloc, CarritoState>(
          listener: (context, state) {
            if (state is CarritoError) {
            } else if (state is CarritoDeleteSucess) {
              _carritoBloc.add(VerCarritoItem(context, carritoRepository));
            }
          },
          builder: (context, state) {
            if (state is CarritoLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is VerCarritoSucess) {
              _initializeImageBlocs(state.carrito);
              return _buildCarritoDetails(state);
            } else if (state is CarritoError) {
              return Center();
            } else {
              return Center();
            }
          },
        ),
      ),
    );
  }

  Widget _buildCarritoDetails(VerCarritoSucess state) {
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
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: BlocBuilder<ImageBloc, ImageState>(
                      bloc: _imageBlocs[index],
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
                  title: Text(lineaCarrito.producto!.name!,
                      style: TextStyle(fontSize: 18)),
                  subtitle: Text('${lineaCarrito.producto!.precio.toString()}€',
                      style: TextStyle(fontSize: 16)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        iconSize: 30,
                        icon: Icon(Icons.add),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CarritoPage(
                                carritoRepository: widget.carritoRepository,
                                productoId: lineaCarrito.producto!.id!,
                              ),
                            ),
                          );
                          setState(() {});
                        },
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text('x${lineaCarrito.cantidad!}',
                          style: TextStyle(color: Colors.black, fontSize: 18)),
                      SizedBox(
                        width: 20,
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
                          })
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
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.disabled))
                          return Colors.grey;
                        return Colors.black;
                      },
                    ),
                  ),
                  onPressed: state.carrito.total! > 0
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EntregaPage(
                                carritoId: state.carrito.id!,
                              ),
                            ),
                          );
                        }
                      : null,
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
  }
}
