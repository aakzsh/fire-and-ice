import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icesicle/screens/game.dart';

class Rules extends StatelessWidget {
  const Rules({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          height: double.infinity,
          width: double.infinity,
          child: SvgPicture.asset(
            'assets/water.svg',
            fit: BoxFit.cover,
          ),
        ),
        Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 100,
              width: 300,
              child: Center(
                  child: Text(
                "GAME RULES",
                style: rulestyle(30.0),
              )),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/wood.png"), fit: BoxFit.cover)),
            ),
            Container(
              height: 300,
              width: 900,
              child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Center(
                    child: Text(
                      "- Select the difficulty level for which you want to play\n\n- Move the puzzle pieces either by tapping on them or using the arrow key. Arrange them in the correct order within the time to prevent ice pieces from melting and win the game.\n\n- You also have 2 special swaps that you can use atmost 2 times to swap position of any blocks",
                      style: rulestyle(25),
                    ),
                  )),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/wood.png"), fit: BoxFit.cover)),
            ),
            MaterialButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Game()),
                      (route) => false);
                },
                child: Hero(
                  tag: 'transition',
                  child: Text(
                    "Start Playing",
                    style: rulestyle(20),
                  ),
                ))
          ],
        ))
      ],
    ));
  }
}

TextStyle rulestyle(x) {
  return TextStyle(color: Color.fromRGBO(65, 26, 3, 1), fontSize: x);
}
