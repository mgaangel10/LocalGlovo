import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_glovo/blocs/bloc/image_bloc.dart';
import 'package:local_glovo/models/response/favorito_resonse.dart';
import 'package:local_glovo/models/response/ver_favorito_response.dart';

import 'package:local_glovo/repositories/carrito/carrito_repository.dart';
import 'package:local_glovo/repositories/comercio/comercio_repository_impl.dart';
import 'package:local_glovo/repositories/favorito/favorito_repository.dart';
import 'package:local_glovo/repositories/favorito/favorito_repository_impl.dart';
import 'package:local_glovo/ui/pages/comercio_details_page.dart';
import '../../blocs/favorito/bloc/favorito_bloc.dart';

class VerFavoritoPage extends StatefulWidget {
  final CarritoRepository carritoRepository;
  const VerFavoritoPage({Key? key, required this.carritoRepository});

  @override
  State<VerFavoritoPage> createState() => _VerFavoritoPageState();
}

class _VerFavoritoPageState extends State<VerFavoritoPage> {
  late FavoritoRepository favoritoRepository;
  late FavoritoBloc _favoritoBloc;
  late List<ImageBloc> _imageBlocs;

  @override
  void initState() {
    super.initState();
    favoritoRepository = FavoritoRepositoryImpl();
    _favoritoBloc = FavoritoBloc(favoritoRepository);

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _favoritoBloc.add(
        VerFavoritoItem(),
      );
    });
  }

  @override
  void dispose() {
    _favoritoBloc.close();
    for (var bloc in _imageBlocs) {
      bloc.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ver Tu lista de favoritos"),
      ),
      body: BlocProvider.value(
        value: _favoritoBloc,
        child: BlocConsumer<FavoritoBloc, FavoritoState>(
          buildWhen: (context, state) {
            return state is FavoritoInitial ||
                state is VerFavoritoSucess ||
                state is FavoritoError ||
                state is FavoritoLoading;
          },
          builder: (context, state) {
            if (state is VerFavoritoSucess) {
              _initializeImageBlocs(state.verFavoritoResponse);
              return _buildVerFavorito(state.verFavoritoResponse);
            } else if (state is FavoritoError) {
              return Text(state.error);
            } else if (state is FavoritoLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
          listener: (BuildContext context, FavoritoState state) {},
        ),
      ),
    );
  }

  void _initializeImageBlocs(List<VerFavoritoResponse> favoritos) {
    _imageBlocs = List.generate(
        favoritos.length, (index) => ImageBloc(ComercioRepositoryImpl()));

    favoritos.asMap().forEach((index, favorito) {
      if (favorito.imagen != null) {
        _imageBlocs[index].add(VerImageItem(fileName: favorito.imagen!));
      }
    });
  }

  Widget _buildVerFavorito(List<VerFavoritoResponse> favoritos) {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: favoritos.length,
      itemBuilder: (context, index) {
        var comercio = favoritos[index];

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ComercioDetailsPage(
                  comercioID: comercio.id!,
                  carritoRepository: widget.carritoRepository,
                ),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.all(10),
            child: Card(
              color: Color.fromARGB(255, 255, 255, 255),
              shadowColor: Color.fromARGB(255, 0, 0, 0),
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(25)),
                      child: BlocBuilder<ImageBloc, ImageState>(
                        bloc: _imageBlocs[index],
                        builder: (context, state) {
                          if (state is ImageLoading) {
                            return CircularProgressIndicator();
                          } else if (state is VerImageSucces) {
                            return Image.memory(
                              state.uint8list1,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            );
                          } else if (state is VerImageError) {
                            return Icon(Icons.error);
                          } else {
                            return SizedBox.shrink();
                          }
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                comercio.name!,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            IconButton(
                              iconSize: 30,
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                final bloc = context.read<FavoritoBloc>();
                                bloc.add(
                                  DeleteFavoritoItem(
                                    comercioId: comercio.id!,
                                  ),
                                );
                                bloc.add(VerFavoritoItem());
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
