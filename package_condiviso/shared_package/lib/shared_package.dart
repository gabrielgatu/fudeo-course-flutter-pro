library shared_package;

import 'package:flutter/material.dart';

/// Post è un componente utilizzato per far vedere un post nel feed dell'utente.
class Post extends StatelessWidget {
  Post({
    @required this.imageUrl,
    @required this.title,
    @required this.body,
  });

  final String imageUrl;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 4 / 3,
            child: Image.network(imageUrl, fit: BoxFit.cover),
          ),
          Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text(body),
                ],
              ))
        ],
      ),
    );
  }
}
