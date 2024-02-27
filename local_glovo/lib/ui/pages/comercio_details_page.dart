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
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read<ComercioDetailsBloc>().add(
            ComercioDetailsItem(comercioId: widget.comercioID),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalles del comercio"),
      ),
      body: BlocBuilder<ComercioDetailsBloc, ComercioDetailsState>(
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
                              comercio.imagen!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 130,
                            ),
                          ),
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
                          subtitle:
                              Center(child: Text(comercio.nameDirection!)),
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
                              onPressed: () {},
                              child: const Text('Añadir al carrito',
                                  style: TextStyle(fontSize: 20)),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )
              ],
            );
          } else if (state is ComercioDetailsInitial) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ComercioDetailsError) {
            return Center(
              child: Text(
                  "Error al cargar los detalles del comercio: ${state.error}"),
            );
          } else {
            return Center(
              child: Text("Estado del bloc desconocido"),
            );
          }
        },
      ),
    );
  }
}
