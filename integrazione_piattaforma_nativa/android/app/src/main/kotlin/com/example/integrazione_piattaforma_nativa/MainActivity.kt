package com.example.integrazione_piattaforma_nativa

import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "it.fudeo.integrazione_piattaforma_nativa/nativeValue").setMethodCallHandler { call, result ->
          result.success("Ciao da Android Nativo!")
        }
      }
}
