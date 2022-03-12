import 'package:flutter/material.dart';
import 'package:icesicle/screens/game.dart';
import 'package:icesicle/constants/constants.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String dropdownVal = 'Easy';
  List<String> difficulty = ['Easy', 'Medium', 'Hard'];

  Map<String, int> difficultyTime = {'Easy': 600, 'Medium': 300, 'Hard': 120};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: double.infinity,
            width: double.infinity,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("IceSicle", style: TextStyle(fontSize: 50)),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        DropdownButton(
                            value: dropdownVal,
                            items: difficulty.map((String items) {
                              return DropdownMenuItem(
                                child: Text(items),
                                value: items,
                              );
                            }).toList(),
                            onChanged: (newVal) {
                              setState(() {
                                dropdownVal = newVal.toString();
                                print(newVal);
                                print(dropdownVal);
                              });
                            }),
                        MaterialButton(
                            onPressed: () {
                              setState(() {
                                timeinitial = difficultyTime[dropdownVal]!;
                                timeleft = difficultyTime[dropdownVal]!;
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Game()));
                            },
                            child: Text("Start"))
                      ])
                ])));
  }
}
