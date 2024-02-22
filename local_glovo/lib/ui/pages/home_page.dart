import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_glovo/blocs/comercio/bloc/comercio_bloc.dart';
import 'package:local_glovo/repositories/comercio/comercio_repository.dart';
import 'package:local_glovo/repositories/comercio/comercio_repository_impl.dart';
import 'package:local_glovo/ui/widget/comercio_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ComercioRepository comercioRepository;
  @override
  void initState() {
    super.initState();
    comercioRepository = ComercioRepositoryImpl();
  }

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
            Expanded(child: _ComercioList()),
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
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Número de tarjetas por fila
            ),
            itemCount: state.comercioList.length,
            itemBuilder: (context, index) {
              final c = state.comercioList[index];
              return ComercioWidget(contentElement: c);
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
          suffixIcon:
              Icon(Icons.search), // Añade un ícono de búsqueda a la derecha
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(30), // Hace que los bordes sean redondos
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
