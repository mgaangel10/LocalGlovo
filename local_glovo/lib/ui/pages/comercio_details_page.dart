import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_glovo/blocs/carrito/bloc/carrito_bloc.dart';
import 'package:local_glovo/blocs/comercio/bloc/comercio_details_bloc.dart';
import 'package:local_glovo/repositories/carrito/carrito_repository.dart';
import 'package:local_glovo/repositories/carrito/carrito_repository_impl.dart';
import 'package:local_glovo/repositories/comercio/comercio_repository.dart';
import 'package:local_glovo/repositories/comercio/comercio_repository_impl.dart';
import 'package:local_glovo/ui/pages/carrito_page.dart';
import 'package:local_glovo/ui/pages/ingredientes_page.dart';

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

  @override
  void initState() {
    super.initState();
    comercioRepository = ComercioRepositoryImpl();
    _comercioDetailsBloc = ComercioDetailsBloc(comercioRepository);
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _comercioDetailsBloc.add(
        ComercioDetailsItem(comercioId: widget.comercioID),
      );
    });
  }

  @override
  void dispose() {
    _comercioDetailsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalles del comercio"),
      ),
      body: BlocProvider.value(
        value: _comercioDetailsBloc,
        child: BlocConsumer<ComercioDetailsBloc, ComercioDetailsState>(
          buildWhen: (context, state) {
            return state is ComercioDetailsInitial ||
                state is ComercioDetailsSucces ||
                state is ComercioDetailsError ||
                state is ComercioDetailsLoading;
          },
          builder: (context, state) {
            if (state is ComercioDetailsSucces) {
              return _buildComercioDetails();
            } else if (state is ComercioDetailsError) {
              return const Text("Error al cargar los detalles del comercio");
            } else if (state is ComercioDetailsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Center(child: _buildComercioDetails());
          },
          listener: (BuildContext context, ComercioDetailsState state) {},
        ),
      ),
    );
  }

  Widget _buildComercioDetails() {
    return BlocBuilder<ComercioDetailsBloc, ComercioDetailsState>(
      builder: (context, state) {
        if (state is ComercioDetailsSucces) {
          final comercio = state.comercio;
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
                            child: Image.network(
                              comercio.imagen != null &&
                                      Uri.parse(comercio.imagen!).isAbsolute
                                  ? comercio.imagen!
                                  : 'https://lh5.googleusercontent.com/p/AF1QipM77k8VJggh1IVj0goQEB17nnwn3RFpKd_HQPFv=w426-h240-k-no',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 130,
                            )),
                      ),
                      ListTile(
                        leading: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(Icons.star, size: 24),
                            Text("${comercio.rating}")
                          ],
                        ),
                        title: Center(child: Text(comercio.name!)),
                        subtitle: Center(child: Text(comercio.nameDirection!)),
                        trailing: Icon(Icons.favorite, color: Colors.pink),
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
                                child: Image.network(
                                  comercio.productos![index].imagen!,
                                ),
                              ),
                            ),
                            title: Center(
                                child: Text(comercio.productos![index].name!)),
                            trailing: Container(
                              margin: EdgeInsets.only(top: 8.0),
                              child:
                                  Text("${comercio.productos?[index].precio}€"),
                            ),
                          ),
                          Center(
                            child: ElevatedButton(
                              onPressed: () async {
                                String productoId =
                                    comercio.productos![index].id!;

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CarritoPage(
                                      productoId: productoId,
                                      carritoRepository:
                                          widget.carritoRepository,
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
        } else {
          return Container();
        }
      },
    );
  }
}
