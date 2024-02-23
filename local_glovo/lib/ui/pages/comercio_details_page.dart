import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_glovo/blocs/comercio/bloc/comercio_details_bloc.dart';

class ComercioDetailsPage extends StatefulWidget {
  final String comercioID;
  const ComercioDetailsPage({super.key, required this.comercioID});

  @override
  State<ComercioDetailsPage> createState() => _ComercioDetailsPageState();
}

class _ComercioDetailsPageState extends State<ComercioDetailsPage> {
  @override
  void initState() {
    super.initState();
    context.read<ComercioDetailsBloc>().add(
          ComercioDetailsItem(comercioId: widget.comercioID),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("detalles del comercio"),
        ),
        body: BlocBuilder<ComercioDetailsBloc, ComercioDetailsState>(
          builder: (context, state) {
            if (state is ComercioDetailsInitial) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ComercioDetailsSucces) {
              final comercio = state.comercio;
              return ListView(
                children: <Widget>[
                  Center(
                    child: Card(
                      margin: EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text("nombre: ${comercio.name}"),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("rating: ${comercio.rating}")
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("direccion: ${comercio.nameDirection}")
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: 10),
                            comercio.imagen != null
                                ? Image.network(comercio.imagen!)
                                : Container(),
                            SizedBox(
                              height: 10,
                            ),
                            Text("productos: ${comercio.productos?[0].name}")
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              );
            } else if (state is ComercioDetailsError) {
              return Center(
                child: Text(
                    "Error al cargar los detalles del comercio: ${state.error}"),
              );
            } else {
              return Center(
                child: Text("estado de bloc desconocido"),
              );
            }
          },
        ));
  }
}
