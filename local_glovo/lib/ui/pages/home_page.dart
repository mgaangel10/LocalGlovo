import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_glovo/blocs/comercio/bloc/comercio_bloc.dart';
import 'package:local_glovo/blocs/comercio/bloc/comercio_details_bloc.dart';
import 'package:local_glovo/blocs/favorito/bloc/favorito_bloc.dart';
import 'package:local_glovo/models/response/comercio_response.dart';
import 'package:local_glovo/repositories/carrito/carrito_repository.dart';
import 'package:local_glovo/repositories/comercio/comercio_repository.dart';
import 'package:local_glovo/repositories/comercio/comercio_repository_impl.dart';
import 'package:local_glovo/ui/pages/User_page.dart';
import 'package:local_glovo/ui/pages/carrito_page.dart';
import 'package:local_glovo/ui/pages/comercio_details_page.dart';
import 'package:local_glovo/ui/widget/botones_filtro.dart';
import 'package:local_glovo/ui/widget/comercio_list.dart';
import 'package:local_glovo/ui/widget/geocalizacion.dart';

class HomePage extends StatefulWidget {
  final CarritoRepository carritoRepository;

  const HomePage({Key? key, required this.carritoRepository}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late ComercioRepository comercioRepository;
  late ComercioBloc _comercioBloc;

  @override
  void initState() {
    super.initState();
    comercioRepository = ComercioRepositoryImpl();
    _comercioBloc = ComercioBloc(comercioRepository)..add(ComercioList());
  }

  static List<Widget> _widgetOptions(CarritoRepository carritoRepository) => [
        HomePage(carritoRepository: carritoRepository),
        UserPage(
          carritoRepository: carritoRepository,
        )
      ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _comercioBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Home page"),
          automaticallyImplyLeading: false,
        ),
        body: Column(
          children: [
            // _buildSearchBar(),
            _buildFilterButtons(),
            Expanded(
              child: ListadoComercios(),
            ),
            Expanded(
              child: _ComercioList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _ComercioList() {
    return BlocBuilder<ComercioBloc, ComercioState>(
      builder: (context, state) {
        if (state is ComercioSuccess) {
          return GridView.builder(
            scrollDirection: Axis.horizontal,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
            ),
            itemCount: state.comercioList.length,
            itemBuilder: (context, index) {
              final c = state.comercioList[index];
              return GestureDetector(
                onTap: () {
                  final comercioRepositorio = ComercioRepositoryImpl();
                  final detallesCoemercio =
                      ComercioDetailsBloc(comercioRepository);
                  detallesCoemercio.add(ComercioDetailsItem(comercioId: c.id!));
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider.value(
                        value: detallesCoemercio,
                        child: ComercioDetailsPage(
                          comercioID: c.id!,
                          carritoRepository: widget.carritoRepository,
                        ),
                      ),
                    ),
                  );
                },
                child: ComercioWidget(
                    contentElement: c,
                    carritoRepository: widget.carritoRepository),
              );
            },
          );
        } else if (state is ComercioCategoriaSucess) {
          return GridView.builder(
            scrollDirection: Axis.horizontal,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
            ),
            itemCount: state.categorias.length,
            itemBuilder: (context, index) {
              final c = state.categorias[index];
              return GestureDetector(
                onTap: () {
                  final comercioRepositorio = ComercioRepositoryImpl();
                  final detallesCoemercio =
                      ComercioDetailsBloc(comercioRepository);
                  detallesCoemercio.add(ComercioDetailsItem(comercioId: c.id!));
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider.value(
                        value: detallesCoemercio,
                        child: ComercioDetailsPage(
                          comercioID: c.id!,
                          carritoRepository: widget.carritoRepository,
                        ),
                      ),
                    ),
                  );
                },
                child: ComercioWidget(
                    contentElement: c,
                    carritoRepository: widget.carritoRepository),
              );
            },
          );
        } else if (state is AddfavoritoSucess) {
          return GridView.builder(
            scrollDirection: Axis.horizontal,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
            ),
            itemCount: state.list.length,
            itemBuilder: (context, index) {
              final c = state.list[index];
              return GestureDetector(
                  onTap: () {
                    final comercioRepositorio = ComercioRepositoryImpl();
                    final detallesCoemercio =
                        ComercioDetailsBloc(comercioRepository);
                    detallesCoemercio
                        .add(ComercioDetailsItem(comercioId: c.id!));
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider.value(
                          value: detallesCoemercio,
                          child: ComercioDetailsPage(
                            comercioID: c.id!,
                            carritoRepository: widget.carritoRepository,
                          ),
                        ),
                      ),
                    );
                  },
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ComercioDetailsPage(
                            comercioID: state.list[0].id!,
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
                                          NetworkImage(state.list[0].imagen!),
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                state.list[0].name!,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.star, color: Colors.yellow),
                                      SizedBox(width: 5),
                                      Text(state.list[0].rating.toString()),
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
                  ));
            },
          );
        } else if (state is ComercioError) {
          print(state.errorMensaje);
          return Text(state.errorMensaje);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  //Widget _buildSearchBar() {
  //return Padding(
  //padding: const EdgeInsets.all(8.0),
  //child: TextField(
  //decoration: InputDecoration(
  //labelText: 'Buscar',
  //suffixIcon: Icon(Icons.search),
  //border: OutlineInputBorder(
  //borderRadius: BorderRadius.circular(30),
  //),
  //),
  //),
  //);
  // }

  Widget _buildFilterButtons() {
    return BlocBuilder<ComercioBloc, ComercioState>(
      builder: (context, state) {
        if (state is ComercioSuccess) {
          return Container(
            height: 60,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.comercioList.length,
              itemBuilder: (context, index) {
                final c = state.comercioList[index];
                return GestureDetector(
                  onTap: () {
                    _comercioBloc
                        .add(ComercioCategoriasItem(categorias: c.categorias!));
                  },
                  child: ElevatedButton(
                    onPressed: () {
                      final comercioRepo = ComercioRepositoryImpl();
                      _comercioBloc.add(
                          ComercioCategoriasItem(categorias: c.categorias!));
                    },
                    child: Row(
                      children: [
                        Text(
                          state.comercioList[index].categorias!,
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        } else if (state is ComercioCategoriaSucess) {
          return Container(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.categorias.length,
              itemBuilder: (context, index) {
                final c = state.categorias[0];
                return GestureDetector(
                  onTap: () {
                    _comercioBloc.add(ComercioList());
                  },
                  child: ElevatedButton(
                      onPressed: () {
                        final comercioRepo = ComercioRepositoryImpl();
                        _comercioBloc.add(ComercioList());
                      },
                      child: Icon(Icons.arrow_back_ios_new)),
                );
              },
            ),
          );
        } else if (state is ComercioError) {
          return Text(state.errorMensaje);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildFilterButton(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(icon),
            SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
