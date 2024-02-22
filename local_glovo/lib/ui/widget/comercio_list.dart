import 'package:flutter/material.dart';
import 'package:local_glovo/models/response/comercio_response.dart';

class ComercioWidget extends StatelessWidget {
  final Content contentElement;
  const ComercioWidget({super.key, required this.contentElement});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Center(
                child: Image(
                  image: NetworkImage(contentElement.imagen!),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text(contentElement.name!)],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(contentElement.rating.toString()),
                  Icon(
                    Icons.favorite,
                    color: Colors.grey,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
