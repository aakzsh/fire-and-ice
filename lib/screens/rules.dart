import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icesicle/screens/game.dart';

bool isLandscape = true;

class Rules extends StatefulWidget {
  const Rules({Key? key}) : super(key: key);

  @override
  State<Rules> createState() => _RulesState();
}

class _RulesState extends State<Rules> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    if (w / h > 1) {
      setState(() {
        isLandscape = true;
      });
    } else {
      setState(() {
        isLandscape = false;
      });
    }

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
              width: isLandscape ? 2 / 3 * w : 0.95 * w,
              child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Center(
                    child: Text(
                      "- Select the difficulty level for which you want to play\n\n- Move the puzzle pieces either by tapping on them or using the arrow key. Arrange them in the correct order within the time to prevent ice pieces from melting and win the game.\n\n- You also have 2 special swaps that you can use atmost 2 times to swap position of any blocks",
                      style: rulestyle(25),
                    ),
                  )),
              decoration: const BoxDecoration(
                color: Color(0xffEEC85D),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color(0xffEEC85D),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(115, 73, 49, 78),
                      offset: Offset(
                        2.0,
                        4.0,
                      ),
                      blurRadius: 4.0,
                    ),
                  ]),
              child: MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Start Playing",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                ),
              ),
            ),
          ],
        ))
      ],
    ));
  }
}

TextStyle rulestyle(x) {
  String size = x.toString();
  return TextStyle(
      color: Color.fromRGBO(65, 26, 3, 1), fontSize: double.parse(size));
}
