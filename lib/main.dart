import 'package:flutter/material.dart';
import 'package:icesicle/screens/blobanimation.dart';
import 'package:icesicle/screens/check.dart';
import 'package:icesicle/screens/game.dart';
import 'package:icesicle/screens/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}
