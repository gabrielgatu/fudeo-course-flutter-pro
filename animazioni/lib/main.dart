import 'package:flutter/material.dart';

import 'package:animazioni/screens/ImplicitlyAnimatedWidgetsPage.dart';
import 'package:animazioni/screens/AnimatedBuilderPage.dart';

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
      initialRoute: "/animated-builder",
      routes: {
        "/implicitly-animated-widgets": (_) => ImplicitlyAnimatedWidgetsPage(),
        "/animated-builder": (_) => AnimatedBuilderPage(),
      },
    );
  }
}
