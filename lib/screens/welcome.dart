import 'package:fireandice/screens/game.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        const Text("fire and ice"),
        const Text("complete the challenge in"),
        const TextField(
          decoration: InputDecoration(hintText: "10s"),
        ),
        MaterialButton(
          child: const Text("play"),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const GameScreen()));
          },
        )
      ],
    ));
  }
}
