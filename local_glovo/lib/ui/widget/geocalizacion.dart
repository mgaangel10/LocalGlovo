import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:local_glovo/models/response/comercio_response.dart';
import 'package:local_glovo/repositories/comercio/comercio_repository.dart';
import 'package:local_glovo/repositories/comercio/comercio_repository_impl.dart';

class ListadoComercios extends StatefulWidget {
  const ListadoComercios({Key? key}) : super(key: key);

  @override
  State<ListadoComercios> createState() => _ListadoComerciosState();
}

class _ListadoComerciosState extends State<ListadoComercios> {
  late Future<List<Content>> list;
  late ComercioRepository comercioRepository;
  late GoogleMapController mapController;

  @override
  void initState() {
    super.initState();
    comercioRepository = ComercioRepositoryImpl();
    list = comercioRepository.listarComercios();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: list,
      builder: (context, AsyncSnapshot<List<Content>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text("Ha ocurrido un error");
        } else {
          final comercioList = snapshot.data!;
          return Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: comercioList.length,
                    itemBuilder: (context, index) {
                      final comercio = comercioList[index];
                      return ListTile(
                        title: Text(comercio.name! + ""),
                        subtitle: Text(comercio.nameDirection! + ""),
                        onTap: () {
                          // Aquí puedes manejar la selección del comercio
                        },
                      );
                    },
                  ),
                ),
                Container(
                  height: 200, // Altura del mapa
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                          comercioList[0].latitud!, comercioList[0].longitud!),
                    ),
                    markers: comercioList.map((comercio) {
                      return Marker(
                        markerId: MarkerId(comercio.id.toString()),
                        position: LatLng(comercio.latitud!, comercio.longitud!),
                        infoWindow: InfoWindow(
                          title: comercio.name!,
                          snippet: comercio.nameDirection!,
                        ),
                      );
                    }).toSet(),
                    onMapCreated: (GoogleMapController controller) {
                      mapController = controller;
                    },
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
