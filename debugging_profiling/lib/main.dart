import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int itemCount = 5;

  void loadMoreItems() async {
    print("loadMoreItems");
    await Future.delayed(Duration(seconds: 2));

    final response = await http.get("https://instagram.com/thisisbillgates/?__a=1");
    print(json.decode(response.body));

    setState(() {
      itemCount += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Debugging e Profiling"),
      ),
      body: ListView.builder(
        itemCount: itemCount,
        itemBuilder: (_, index) {
          if (index == itemCount - 1)
            return FlatButton(
              onPressed: loadMoreItems,
              child: Text("Carica un altro elemento"),
            );
          else
            return ListTile(title: Text("Tile: $index"));
        },
      ),
    );
  }
}
