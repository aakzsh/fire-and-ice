import 'package:flutter/material.dart';
import 'package:icesicle/screens/game.dart';

class Result extends StatefulWidget {
  const Result({Key? key}) : super(key: key);

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Center(
          child: Column(
        children: <Widget>[
          Text("you won lmaoo"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MaterialButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Game()),
                      (route) => false);
                },
                child: Text("replay"),
              ),
            ],
          )
        ],
      )),
    ));
  }
}
