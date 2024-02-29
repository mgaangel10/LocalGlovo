import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_glovo/blocs/carrito/bloc/carrito_bloc.dart';
import 'package:local_glovo/models/response/add_producto_to_cart/add_producto_to_cart.dart';
import 'package:local_glovo/repositories/carrito/carrito_repository.dart';

class CarritoPage extends StatefulWidget {
  final CarritoRepository carritoRepository;
  final String usuarioId;
  const CarritoPage(
      {super.key, required this.usuarioId, required this.carritoRepository});

  @override
  State<CarritoPage> createState() => _CarritoPageState();
}

class _CarritoPageState extends State<CarritoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi carrito'),
      ),
      body: BlocBuilder<CarritoBloc, CarritoState>(
        builder: (context, state) {
          if (state is CarritoLoading) {
            return CircularProgressIndicator();
          } else if (state is CarritoSucces) {
            return ListView.builder(
              itemCount: state.carrito.lineasCarrito?.length ?? 0,
              itemBuilder: (context, index) {
                final lineaCarrito = state.carrito.lineasCarrito![index];
                return Card(
                  child: ListTile(
                    leading: Image.network(lineaCarrito.producto!.imagen!),
                    title: Text(lineaCarrito.producto!.name!),
                    subtitle:
                        Text('${lineaCarrito.producto!.precio.toString()}€'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        // Aquí puedes implementar la lógica para eliminar un producto del carrito
                      },
                    ),
                  ),
                );
              },
            );
          } else if (state is CarritoError) {
            return Text('Error al cargar el carrito: ${state.error}');
          } else {
            return Text('Estado desconocido');
          }
        },
      ),
    );
  }
}
