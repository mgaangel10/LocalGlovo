import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_glovo/blocs/bloc/image_bloc.dart';
import 'package:local_glovo/blocs/comercio/bloc/comercio_bloc.dart';
import 'package:local_glovo/models/response/comercio_response.dart';
import 'package:local_glovo/repositories/carrito/carrito_repository.dart';
import 'package:local_glovo/repositories/comercio/comercio_repository.dart';
import 'package:local_glovo/repositories/comercio/comercio_repository_impl.dart';
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
  late ComercioRepository comercioRepository;
  late FavoritoBloc _favoritoBloc;
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 0;
  bool _isLoading = false;

  void addToFavorites(String comercioId) {
    _favoritoBloc.add(
      AddFavoritoItem(comercioId: comercioId),
    );
  }

  @override
  void initState() {
    super.initState();
    _currentPage = 0; // Reiniciar el contador de página
    favoritoRepository = FavoritoRepositoryImpl();
    comercioRepository = ComercioRepositoryImpl();
    _favoritoBloc = FavoritoBloc(favoritoRepository);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == 0 && !_isLoading) {
        SchedulerBinding.instance!.addPostFrameCallback((_) {
          _loadPreviousPage();
        });
      } else if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !_isLoading) {
        SchedulerBinding.instance!.addPostFrameCallback((_) {
          _loadMore();
        });
      }
    });
  }

  Future<void> _loadPreviousPage() async {
    setState(() {
      _isLoading = true;
    });
    _currentPage--;
    context.read<ComercioBloc>().add(ComercioFetchMore(page: _currentPage));
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _loadMore() async {
    setState(() {
      _isLoading = true;
    });
    _currentPage++;
    context.read<ComercioBloc>().add(ComercioFetchMore(page: _currentPage));
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImageBloc(comercioRepository)
        ..add(VerImageItem(fileName: widget.contentElement.imagen!)),
      child: GestureDetector(
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
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(25)),
                    child: BlocBuilder<ImageBloc, ImageState>(
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            widget.contentElement.name!,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
