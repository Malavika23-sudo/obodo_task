import 'package:flutter/material.dart';
import 'package:obodo_app/routes.dart';
import 'package:obodo_app/screens/home_screen.dart';
import 'package:obodo_app/theme.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: theme(),
        initialRoute: HomeScreen.routeName,
        routes: routes,
      );
  }
}