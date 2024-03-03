import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_glovo/blocs/ingredientes/bloc/view_ingredientes_bloc.dart';
import 'package:local_glovo/models/response/comercio_details_response.dart';
import 'package:local_glovo/repositories/comercio/comercio_repository.dart';
import 'package:local_glovo/repositories/comercio/comercio_repository_impl.dart';

class IngredientesPage extends StatefulWidget {
  final Productos productos;

  const IngredientesPage({Key? key, required this.productos}) : super(key: key);

  @override
  State<IngredientesPage> createState() => _IngredientesPageState();
}

class _IngredientesPageState extends State<IngredientesPage> {
  late ComercioRepository comercioRepository;
  late ViewIngredientesBloc _ingredientesBloc;

  @override
  void initState() {
    super.initState();
    comercioRepository = ComercioRepositoryImpl();
    _ingredientesBloc = ViewIngredientesBloc(comercioRepository);
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _ingredientesBloc.add(
        IngredientesItem(id: widget.productos.id!),
      );
    });
  }

  @override
  void dispose() {
    _ingredientesBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalles de ingredientes"),
      ),
      body: BlocProvider.value(
        value: _ingredientesBloc,
        child: BlocConsumer<ViewIngredientesBloc, ViewIngredientesState>(
          builder: (context, state) {
            if (state is ViewIngredientesLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is IngredientesSucces) {
              return _buildIngredientesDetails(state.ingredientes);
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
          },
          listener: (BuildContext context, ViewIngredientesState state) {},
        ),
      ),
    );
  }

  Widget _buildIngredientesDetails(Productos ingredientes) {
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.network(
                      ingredientes.imagen!,
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
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Colors.white,
              elevation: 10,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.0), // Ajusta el padding horizontal
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              widget.productos.ingredientes![index].imagen!,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      "${widget.productos.ingredientes![index].name}",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text("Eliminar"),
                    ),
                  ),
                ],
              ),
            );
          },
        )
      ],
    );
  }
}
