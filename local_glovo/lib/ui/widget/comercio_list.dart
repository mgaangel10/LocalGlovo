import 'package:flutter/material.dart';
import 'package:local_glovo/models/response/comercio_response.dart';
import 'package:local_glovo/repositories/carrito/carrito_repository.dart';
import 'package:local_glovo/ui/pages/comercio_details_page.dart';
import 'package:local_glovo/ui/pages/favorito_page.dart';
import 'package:local_glovo/repositories/favorito/favorito_repository.dart';
import 'package:local_glovo/repositories/favorito/favorito_repository_impl.dart';
import 'package:local_glovo/blocs/favorito/bloc/favorito_bloc.dart';

class ComercioWidget extends StatefulWidget {
  final CarritoRepository carritoRepository;
  final Content contentElement;
  const ComercioWidget(
      {super.key,
      required this.contentElement,
      required this.carritoRepository});

  @override
  _ComercioWidgetState createState() => _ComercioWidgetState();
}

class _ComercioWidgetState extends State<ComercioWidget> {
  late FavoritoRepository favoritoRepository;
  late FavoritoBloc _favoritoBloc;

  @override
  void initState() {
    super.initState();
    favoritoRepository = FavoritoRepositoryImpl();
    _favoritoBloc = FavoritoBloc(favoritoRepository);
  }

  void addToFavorites(String comercioId) {
    _favoritoBloc.add(
      AddFavoritoItem(comercioId: comercioId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ComercioDetailsPage(
              comercioID: widget.contentElement.id!,
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
                        image: NetworkImage(widget.contentElement.imagen!),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  widget.contentElement.name!,
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
                      children: [],
                    ),
                    ElevatedButton(
                        onPressed: () {
                          addToFavorites(widget.contentElement.id!);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(widget.contentElement.name! +
                                    ' se ha añadido a favorito'),
                                actions: <Widget>[
                                  TextButton(
                                    child: Icon(Icons.cancel_sharp),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Icon(
                          Icons.favorite,
                          color: Colors.grey,
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
