import 'package:flutter/material.dart';
import 'package:shared_package/shared_package.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.indigo,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Package esterno"),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemCount: 10,
        itemBuilder: (context, index) => Post(
            imageUrl:
                "https://images.unsplash.com/photo-1603174378108-63103ad2f24b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=934&q=80",
            title: "Lorem ipsum",
            body:
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin lobortis nunc a massa convallis fermentum. Nulla nec ante auctor, sodales ex et, hendrerit ante. "),
        separatorBuilder: (context, index) => SizedBox(height: 10),
      ),
    );
  }
}
