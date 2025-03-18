import 'dart:async';
import 'dart:html'; // For manipulating HTML elements on the web
import 'dart:js' as js;

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart'; // for kIsWeb
import 'package:flutter/material.dart';
import 'login.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // For web, load the gapi script and initialize gapi.client
  if (kIsWeb) {
    await _loadGapiClient();
  }

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const MyApp());
}

/// Loads the Google API script dynamically and waits for it to load.
Future<void> _loadGapiClient() async {
  final script = ScriptElement()
    ..src = "https://apis.google.com/js/api.js"
    ..async = true
    ..defer = true;

  final completer = Completer<void>();

  script.onLoad.listen((event) {
    print('gapi script loaded successfully.');
    // Wait briefly to ensure gapi is attached to the window object.
    Future.delayed(const Duration(seconds: 2), () {
      _initializeGapiClient();
      completer.complete();
    });
  });

  script.onError.listen((error) {
    print("Error loading gapi script: $error");
    completer.completeError(error);
  });

  document.body!.append(script);
  return completer.future;
}

/// Initializes the gapi client and auth2 libraries.
void _initializeGapiClient() {
  // Check if gapi is available on window (js.context)
  if (js.context.hasProperty('gapi')) {
    var gapi = js.context['gapi'];
    print("Initializing gapi client...");
    gapi.callMethod('load', [
      'client:auth2',
      js.allowInterop(() {
        print("gapi client:auth2 loaded. Now initializing client.");
        // Initialize the gapi client with your client ID and required scopes.
        gapi.callMethod('client', [
          'init',
          {
            'clientId': '747550843096-rrq5nagcisu2h556rr9bcs4ktihg6c0c.apps.googleusercontent.com',
            'scope': 'email profile openid'
          }
        ]).then((_) {
          print("gapi client initialized successfully.");
        }).catchError((error) {
          print("Error during gapi.client.init: $error");
        });
      })
    ]);
  } else {
    print("gapi is not available in js.context");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
