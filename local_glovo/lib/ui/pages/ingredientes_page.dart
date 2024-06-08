import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_glovo/blocs/bloc/image_bloc.dart';
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
  late List<ImageBloc> _imageBlocs;

  @override
  void initState() {
    super.initState();
    comercioRepository = ComercioRepositoryImpl();
    _ingredientesBloc = ViewIngredientesBloc(comercioRepository);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _ingredientesBloc.add(
        IngredientesItem(id: widget.productos.id!),
      );
    });
  }

  @override
  void dispose() {
    _ingredientesBloc.close();
    for (var bloc in _imageBlocs) {
      bloc.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalles de ingredientes"),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<ViewIngredientesBloc>.value(value: _ingredientesBloc),
        ],
        child: BlocConsumer<ViewIngredientesBloc, ViewIngredientesState>(
          buildWhen: (context, state) {
            return state is ViewIngredientesInitial ||
                state is IngredientesSucces ||
                state is IngredientesError ||
                state is ViewIngredientesLoading;
          },
          builder: (context, state) {
            if (state is IngredientesSucces) {
              _initializeImageBlocs(state.ingredientes);
              return _buildIngredientesDetails(state.ingredientes);
            } else if (state is IngredientesError) {
              return const Text("Error al cargar los detalles de ingredientes");
            } else if (state is ViewIngredientesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return const SizedBox.shrink();
          },
          listener: (BuildContext context, ViewIngredientesState state) {},
        ),
      ),
    );
  }

  void _initializeImageBlocs(Productos ingredientes) {
    final totalImages = 1 + (ingredientes.ingredientes?.length ?? 0);
    _imageBlocs =
        List.generate(totalImages, (index) => ImageBloc(comercioRepository));

    if (ingredientes.imagen != null) {
      _imageBlocs[0].add(VerImageItem(fileName: ingredientes.imagen!));
    }

    ingredientes.ingredientes?.asMap().forEach((index, ingrediente) {
      if (ingrediente.imagen != null) {
        _imageBlocs[index + 1].add(VerImageItem(fileName: ingrediente.imagen!));
      }
    });
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
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: BlocBuilder<ImageBloc, ImageState>(
                      bloc: _imageBlocs[0],
                      builder: (context, state) {
                        if (state is ImageLoading) {
                          return CircularProgressIndicator();
                        } else if (state is VerImageSucces) {
                          return Image.memory(
                            state.uint8list1,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 130,
                          );
                        } else if (state is VerImageError) {
                          return Icon(Icons.error);
                        } else {
                          return Icon(Icons.image_not_supported, size: 130);
                        }
                      },
                    ),
                  ),
                ),
                ListTile(
                  leading: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[],
                  ),
                  title: Center(child: Text(ingredientes.name!)),
                  subtitle: Center(child: Text(ingredientes.name!)),
                ),
              ],
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: ingredientes.ingredientes!.length,
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
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Container(
                            margin: EdgeInsets.only(right: 8.0),
                            child: BlocBuilder<ImageBloc, ImageState>(
                              bloc: _imageBlocs[index + 1],
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
                                  return Icon(Icons.image_not_supported,
                                      size: 50);
                                }
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              ingredientes.ingredientes![index].name!,
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
