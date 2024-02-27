import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_glovo/blocs/ingredientes/bloc/view_ingredientes_bloc.dart';
import 'package:local_glovo/models/response/comercio_details_response.dart';

class IngredientesPage extends StatefulWidget {
  final Productos productos;
  const IngredientesPage({super.key, required this.productos});

  @override
  State<IngredientesPage> createState() => _IngredientesPageState();
}

class _IngredientesPageState extends State<IngredientesPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPersistentFrameCallback((_) {
      context.read<ViewIngredientesBloc>().add(
            IngredientesItem(id: widget.productos.id!),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalles de ingredientes"),
      ),
      body: BlocBuilder<ViewIngredientesBloc, ViewIngredientesState>(
          builder: (context, state) {
        if (state is IngredientesSucces) {
          final ingredientes = state.ingredientes;
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
                            ingredientes.name!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 130,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Row(
                          mainAxisSize: MainAxisSize.min,
                        ),
                        title: Center(child: Text(ingredientes.name!)),
                        subtitle: Center(
                          child: Text(ingredientes.name!),
                        ),
                        trailing: Icon(Icons.favorite),
                      ),
                    ],
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.productos.ingredientes!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
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
                              margin: EdgeInsets.only(top: 8.0),
                              child: Text(
                                  "${widget.productos.ingredientes![index].name}"),
                            ),
                          ),
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {},
                            child: const Text("Eliminar"),
                          ),
                        )
                      ],
                    ),
                  );
                },
              )
            ],
          );
        } else if (state is ViewIngredientesInitial) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is IngredientesError) {
          return Center(
            child: Text(
                "Error al cargar los detalles de Ingredientes: ${state.error}"),
          );
        } else {
          return Center(
            child: Text("Estado del bloc desconocido"),
          );
        }
      }),
    );
  }
}
