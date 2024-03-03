import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_glovo/blocs/comercio/bloc/comercio_bloc.dart';
import 'package:local_glovo/blocs/comercio/bloc/comercio_details_bloc.dart';
import 'package:local_glovo/repositories/carrito/carrito_repository.dart';
import 'package:local_glovo/repositories/comercio/comercio_repository.dart';
import 'package:local_glovo/repositories/comercio/comercio_repository_impl.dart';
import 'package:local_glovo/ui/pages/carrito_page.dart';
import 'package:local_glovo/ui/pages/comercio_details_page.dart';
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
  @override
  void initState() {
    super.initState();
    comercioRepository = ComercioRepositoryImpl();
  }

  static List<Widget> _widgetOptions(CarritoRepository carritoRepository) => [
        HomePage(carritoRepository: carritoRepository),
      ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ComercioBloc(comercioRepository)..add(ComercioList()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Home page"),
        ),
        body: Column(
          children: [
            _buildSearchBar(),
            _buildFilterButtons(),
            Expanded(
              child: ListadoComercios(),
            ),
            Expanded(
              child: _ComercioList(),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            color: Colors.black,
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Colors.white),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart, color: Colors.white),
                label: 'Shop',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person, color: Colors.white),
                label: 'Profile',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.deepPurple,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }

  Widget _ComercioList() {
    return BlocBuilder<ComercioBloc, ComercioState>(
      builder: (context, state) {
        if (state is ComercioSuccess) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
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

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: 'Buscar',
          suffixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterButtons() {
    return Container(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          _buildFilterButton('Filtro 1', Icons.fastfood_sharp),
          _buildFilterButton('Filtro 2', Icons.local_pharmacy_outlined),
          _buildFilterButton('Filtro 3', Icons.living_outlined),
          _buildFilterButton('Filtro 4', Icons.filter_4),
          _buildFilterButton('Filtro 5', Icons.filter_5),
        ],
      ),
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
            Icon(icon), // Usa el ícono pasado como parámetro
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
