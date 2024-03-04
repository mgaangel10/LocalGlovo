import 'package:flutter/material.dart';
import 'package:local_glovo/models/response/comercio_response.dart';
import 'package:local_glovo/repositories/carrito/carrito_repository.dart';
import 'package:local_glovo/ui/pages/comercio_details_page.dart';

class ComercioWidget extends StatelessWidget {
  final CarritoRepository carritoRepository;
  final Content contentElement;
  const ComercioWidget(
      {super.key,
      required this.contentElement,
      required this.carritoRepository});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ComercioDetailsPage(
              comercioID: contentElement.id!,
              carritoRepository: carritoRepository,
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
                        image: NetworkImage(contentElement.imagen!),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  contentElement.name!,
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
                        Text(contentElement.rating.toString()),
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
  }
}
