import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_glovo/blocs/carrito/bloc/carrito_bloc.dart';
import 'package:local_glovo/repositories/carrito/carrito_repository.dart';
import 'package:local_glovo/repositories/carrito/carrito_repository_impl.dart';
import 'package:local_glovo/ui/pages/home_page.dart';
import 'package:local_glovo/ui/pages/metodos_pago.dart';

class EntregaPage extends StatefulWidget {
  final String carritoId;
  const EntregaPage({super.key, required this.carritoId});

  @override
  State<EntregaPage> createState() => _EntregaPageState();
}

class _EntregaPageState extends State<EntregaPage> {
  late CarritoRepository carritoRepository;
  late CarritoBloc _carritoBloc;

  @override
  void initState() {
    super.initState();
    carritoRepository = CarritoRepositoryImpl();
    _carritoBloc = CarritoBloc(carritoRepository);
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _carritoBloc.add(CarritoTerminadoItem(carritoId: widget.carritoId));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("¿Como quieres la entrega?"),
      ),
      body: BlocProvider.value(
        value: _carritoBloc,
        child: BlocConsumer<CarritoBloc, CarritoState>(
          buildWhen: (context, state) {
            return state is CarritoInitial ||
                state is CarritoTerminadoSucess ||
                state is CarritoError ||
                state is CarritoLoading;
          },
          builder: (context, state) {
            if (state is CarritoTerminadoSucess) {
              return _buildEntregaState();
            } else if (state is CarritoError) {
              return const Text("error al cargar la entrega");
            } else if (state is CarritoLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Center(
              child: _buildEntregaState(),
            );
          },
          listener: (BuildContext context, CarritoState state) {},
        ),
      ),
    );
  }

  Widget _buildEntregaState() {
    return BlocBuilder<CarritoBloc, CarritoState>(builder: (context, state) {
      if (state is CarritoTerminadoSucess) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Navegar a MetodoPagoPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MetodoPagoPage(
                            carritoRepository: carritoRepository)),
                  );
                },
                child: const ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  title: Text(
                    'A Domicilio',
                    style: TextStyle(fontSize: 20),
                  ),
                  trailing: Icon(Icons.motorcycle_sharp,
                      size: 40), // Icono a la derecha
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Navegar a MetodoPagoPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            HomePage(carritoRepository: carritoRepository)),
                  );
                },
                child: const ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  title: Text(
                    'En Tienda',
                    style: TextStyle(fontSize: 20),
                  ),
                  trailing:
                      Icon(Icons.storefront, size: 40), // Icono a la derecha
                ),
              ),
            ],
          ),
        );
      } else {
        return Container();
      }
    });
  }
}
