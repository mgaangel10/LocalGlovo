import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_glovo/blocs/favorito/bloc/favorito_bloc.dart';
import 'package:local_glovo/repositories/carrito/carrito_repository.dart';
import 'package:local_glovo/repositories/favorito/favorito_repository.dart';
import 'package:local_glovo/repositories/favorito/favorito_repository_impl.dart';
import 'package:local_glovo/ui/pages/comercio_details_page.dart';

class FavoritoPage extends StatefulWidget {
  final String comercioId;
  final CarritoRepository carritoRepository;
  const FavoritoPage(
      {super.key, required this.carritoRepository, required this.comercioId});

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
        AddFavoritoItem(comercioId: widget.comercioId),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Añadido a tus favoritos"),
      ),
      body: BlocProvider.value(
        value: _favoritoBloc,
        child: BlocConsumer<FavoritoBloc, FavoritoState>(
          buildWhen: (context, state) {
            return state is FavoritoInitial ||
                state is AddfavoritoSucess ||
                state is FavoritoError ||
                state is FavoritoLoading;
          },
          builder: (context, state) {
            if (state is AddfavoritoSucess) {
              return _buildVerFavorito();
            } else if (state is FavoritoError) {
              return Text(state.error);
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
      if (state is AddfavoritoSucess) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ComercioDetailsPage(
                  comercioID: state.favoritoResponse.id!,
                  carritoRepository: widget.carritoRepository,
                ),
              ),
            );
          },
          child: Center(
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
                            image: NetworkImage(state.favoritoResponse.imagen!),
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      state.favoritoResponse.name!,
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
                            Text(state.favoritoResponse.rating.toString()),
                          ],
                        ),
                        Icon(
                          Icons.favorite,
                          color: const Color.fromARGB(255, 252, 0, 0),
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
