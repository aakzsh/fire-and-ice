import 'package:flutter/material.dart';
import 'package:icesicle/animations/mascot.dart';
import 'package:icesicle/screens/game.dart';
import 'package:icesicle/screens/home.dart';

import 'package:flutter_svg/flutter_svg.dart';

class GameOver extends StatefulWidget {
  const GameOver({Key? key}) : super(key: key);

  @override
  State<GameOver> createState() => _GameOverState();
}

String message = "Well Done!!";
int time = 0;
String bottommsg = "You've completed the level in $time seconds";

class _GameOverState extends State<GameOver> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              child: SvgPicture.asset(
                'assets/water.svg',
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Image.asset(
                'assets/island-group.png',
                width: w / 2,
              ),
            ),
            Center(
              child: Container(
                width: 2 * w / 3,
                height: h / 2,
                padding: EdgeInsets.all(50),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.pink,
                      image: DecorationImage(
                          image: AssetImage('assets/wood.png'),
                          fit: BoxFit.cover)),
                  child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Stack(
                        children: <Widget>[
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(message,
                                    style: TextStyle(
                                        color: Color(0xff411A03),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 30)),
                                SizedBox(
                                  height: 20,
                                ),
                                Text('$bottommsg',
                                    style: TextStyle(
                                        color: Color.fromARGB(199, 65, 26, 3),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18)),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Color(0xffEEC85D),
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              Color.fromRGBO(115, 73, 49, 78),
                                          offset: Offset(
                                            2.0,
                                            4.0,
                                          ),
                                          blurRadius: 4.0,
                                        ),
                                      ]),
                                  child: MaterialButton(
                                    onPressed: () {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeScreen()),
                                          (route) => false);
                                    },
                                    child: Text("Play Again",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                height: 400,
                                width: 400,
                                child: Mascot,
                              )
                            ],
                          )
                        ],
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
