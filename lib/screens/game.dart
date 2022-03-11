import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  State<Game> createState() => _GameState();
}

List<int> pos = [
  0,
  1,
  2,
  3,
  4,
  5,
  6,
  7,
  8,
  9,
  10,
  11,
  12,
  13,
  14,
  15,
  16,
  17,
  18,
  19,
  20,
  21,
  22,
  23,
  24
];

List<int> posCheck = [
  0,
  1,
  2,
  3,
  4,
  5,
  6,
  7,
  8,
  9,
  10,
  11,
  12,
  13,
  14,
  15,
  16,
  17,
  18,
  19,
  20,
  21,
  22,
  23,
  24
];

class _GameState extends State<Game> {
  checkpos(index) {
    int _24index = pos.indexOf(24);
    if ((index - _24index).abs() == 1) {
      setState(() {
        int x = pos[index];
        pos[index] = pos[_24index];
        pos[_24index] = x;
      });

      if (pos == posCheck) {
        print("won the game");
      }
    } else if ((index - _24index).abs() == 5) {
      setState(() {
        int x = pos[index];
        pos[index] = pos[_24index];
        pos[_24index] = x;
      });

      if (pos == posCheck) {
        print("won the game");
      }
    }
  }

  Widget retWidget(index) {
    if (pos[index] == 24) {
      return Container(
        color: Colors.blue.withOpacity(0.3),
        child: Center(child: Text(pos[index].toString())),
      );
    }

    return InkWell(
      onTap: () {
        checkpos(index);
      },
      child: Container(
        color: Colors.blue,
        child: Center(child: Text(pos[index].toString())),
      ),
    );
  }

  keyPressed(val) {
    if (val == "4294968068") {
      if (pos.indexOf(24) <= 24) {
        checkpos(pos.indexOf(24) + 5);
      }
    } else if (val == "4294968066") {
      if (![4, 9, 14, 19, 24].contains(pos.indexOf(24))) {
        checkpos(pos.indexOf(24) + 1);
      }
    } else if (val == "4294968067") {
      if (![0, 5, 10, 15, 20].contains(pos.indexOf(24))) {
        checkpos(pos.indexOf(24) - 1);
      }
    } else if (val == "4294968065") {
      if (pos.indexOf(24) > 4) {
        checkpos(pos.indexOf(24) - 5);
      }
    } else {
      print("no relevant key pressed");
    }
  }

  @override
  void initState() {
    pos.shuffle();
    super.initState();
  }

  String x = "lol";
  final FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    // pos.shuffle();
    double h = MediaQuery.of(context).size.height;
    return RawKeyboardListener(
      focusNode: _focusNode,
      onKey: ((RawKeyEvent event) {
        print(event.logicalKey.keyId);
        if (event is RawKeyDownEvent) {
          keyPressed(event.logicalKey.keyId.toString());
        }

        setState(() {
          x = "lmao";
        });
      }),
      child: Builder(
        builder: (context) {
          if (!_focusNode.hasFocus) {
            FocusScope.of(context).requestFocus(_focusNode);
          }
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  setState(() {
                    // int x = pos[0];
                    // pos[0] = pos[4];
                    // pos[4] = x;
                    pos.shuffle();
                  });
                },
                icon: Icon(Icons.abc),
              ),
              title: Text(x),
            ),
            body: Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.deepPurple,
              child: Center(
                  child: Container(
                height: h - 100,
                width: h - 100,
                color: Colors.pinkAccent,
                child: GridView.count(
                    crossAxisCount: 5,
                    children: List.generate(25, (index) {
                      return Padding(
                          padding: EdgeInsets.all(2), child: retWidget(index));
                    })),
              )),
            ),
          );
        },
      ),
    );
  }
}
