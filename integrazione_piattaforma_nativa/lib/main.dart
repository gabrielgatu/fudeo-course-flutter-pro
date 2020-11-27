import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const platform = MethodChannel("it.fudeo.integrazione_piattaforma_nativa/nativeValue");

  String nativePlatformValue = "-";

  void onSubmit() async {
    try {
      final String result = await platform.invokeMethod("getNativeValue");
      setState(() => nativePlatformValue = result);
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Integrazione piattaforma nativa"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Valore otteuto da piattaforma nativa:"),
            SizedBox(height: 10),
            Text(nativePlatformValue),
            SizedBox(height: 10),
            RaisedButton(
              onPressed: onSubmit,
              color: Colors.indigo,
              textColor: Colors.white,
              child: Text("Invoca getPlatformValue() nativo"),
            )
          ],
        ),
      ),
    );
  }
}
