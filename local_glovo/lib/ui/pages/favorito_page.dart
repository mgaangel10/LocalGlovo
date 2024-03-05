import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_glovo/blocs/favorito/bloc/favorito_bloc.dart';
import 'package:local_glovo/repositories/carrito/carrito_repository.dart';
import 'package:local_glovo/repositories/favorito/favorito_repository.dart';
import 'package:local_glovo/repositories/favorito/favorito_repository_impl.dart';
import 'package:local_glovo/ui/pages/comercio_details_page.dart';

class FavoritoPage extends StatefulWidget {
  final CarritoRepository carritoRepository;
  const FavoritoPage({super.key, required this.carritoRepository});

  @override
  State<FavoritoPage> createState() => _FavoritoPageState();
}

class _FavoritoPageState extends State<FavoritoPage> {
  late FavoritoRepository favoritoRepository;
  late FavoritoBloc _favoritoBloc;

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
              return _buildVerFavorito();
            } else if (state is FavoritoError) {
              return const Text("error al cargar los favoritos");
            } else if (state is FavoritoLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Center(child: _buildVerFavorito());
          },
          listener: (BuildContext context, FavoritoState state) {},
        ),
      ),
    );
  }

  Widget _buildVerFavorito() {
    return BlocBuilder<FavoritoBloc, FavoritoState>(builder: (context, state) {
      if (state is VerFavoritoSucess) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ComercioDetailsPage(
                  comercioID: state.verFavoritoResponse.id!,
                  carritoRepository: widget.carritoRepository,
                ),
              ),
            );
          },
          child: Container(
            width: 130,
            height: 211,
            child: Card(
              color: Color.fromARGB(255, 255, 255, 255),
              shadowColor: Color.fromARGB(255, 0, 0, 0),
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Image(
                            image:
                                NetworkImage(state.verFavoritoResponse.imagen!),
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      state.verFavoritoResponse.name!,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.yellow),
                            SizedBox(width: 5),
                            Text(state.verFavoritoResponse.rating.toString()),
                          ],
                        ),
                        Icon(
                          Icons.favorite,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      } else {
        return Container();
      }
    });
  }
}
