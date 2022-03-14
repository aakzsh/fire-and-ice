import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icesicle/screens/game.dart';
import 'package:icesicle/constants/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icesicle/screens/rules.dart';
import 'package:auto_size_text/auto_size_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

List<String> level = ["Easy", "Medium", "Hard"];
String selectedLevel = level[0];
final AudioCache _audioCache = AudioCache(
  prefix: 'audio/',
  fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP),
);

class _HomeScreenState extends State<HomeScreen> {
  final FocusNode _focusNodee = FocusNode();
  List<String> difficulty = ['Easy', 'Medium', 'Hard'];

  Map<String, int> difficultyTime = {'Easy': 600, 'Medium': 300, 'Hard': 120};
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return RawKeyboardListener(
        onKey: ((RawKeyEvent event) {
          print(event.logicalKey.keyId);
          if (event is RawKeyDownEvent) {
            // keyPressed(event.logicalKey.keyId.toString());
            if (event.logicalKey.keyId.toString() == "4294968066") {
              try {
                _audioCache.play('change_level.mp3');
              } catch (error) {
                SystemSound.play(SystemSoundType.click);
              }
              if (selectedLevel != "Easy") {
                setState(() {
                  selectedLevel = level[level.indexOf(selectedLevel) - 1];
                });
              } else {
                setState(() {
                  selectedLevel = "Hard";
                });
              }
              print("right");
            } else if (event.logicalKey.keyId.toString() == "4294968067") {
              try {
                _audioCache.play('change_level.mp3');
              } catch (error) {
                SystemSound.play(SystemSoundType.click);
              }
              if (selectedLevel != "Hard") {
                setState(() {
                  selectedLevel = level[level.indexOf(selectedLevel) + 1];
                });
              } else {
                setState(() {
                  selectedLevel = "Easy";
                });
              }
              print("left");
            } else if (event.logicalKey.keyId.toString() == "4294967309") {
              try {
                _audioCache.play('button_press.mp3');
              } catch (error) {
                SystemSound.play(SystemSoundType.click);
              }
              setState(() {
                timeinitial = difficultyTime[selectedLevel]!;
                timeleft = difficultyTime[selectedLevel]!;
              });
              Navigator.pushAndRemoveUntil(
                  context,
                  PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 400),
                      pageBuilder: (_, __, ___) => Game()),
                  (route) => false);
              // Navigator.pushAndRemoveUntil(
              //     context,
              //     MaterialPageRoute(builder: (context) => Game()),
              //     (route) => false);
            }
            print(event.logicalKey.keyId.toString());
          }
        }),
        focusNode: _focusNodee,
        child: Builder(builder: (context) {
          if (!_focusNodee.hasFocus) {
            FocusScope.of(context).requestFocus(_focusNodee);
          }
          return Scaffold(
            backgroundColor: Color.fromRGBO(46, 45, 45, 1),
            body: Stack(
              children: <Widget>[
                Align(
                    alignment: Alignment.topCenter,
                    child: Stack(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: w - 20,
                              height: 3 * h / 4,
                              child: Image.asset(
                                "assets/monitor.png",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.fromLTRB(w / 12, 40, 0, 0),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Icesicle",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )),
                            InkWell(
                              child: Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(0, 40, w / 12, 0),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "rules",
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Rules()));
                              },
                            )
                          ],
                        )
                      ],
                    )),
                Container(
                  height: h,
                  width: w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: h / 2 - 110, left: w / 12, right: w / 12),
                        child: Column(
                          children: <Widget>[
                            AutoSizeText("Choose a level to continue",
                                maxLines: 1,
                                style: GoogleFonts.pressStart2p(
                                    textStyle: TextStyle(
                                        color: Colors.white, fontSize: 25))),
                            SizedBox(
                              height: 20,
                            ),
                            Transform.scale(
                              scale: 0.75,
                              child: Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    IconButton(
                                        onPressed: () {
                                          try {
                                            _audioCache
                                                .play('change_level.mp3');
                                          } catch (error) {
                                            SystemSound.play(
                                                SystemSoundType.click);
                                          }
                                          if (selectedLevel != "Easy") {
                                            setState(() {
                                              selectedLevel = level[
                                                  level.indexOf(selectedLevel) -
                                                      1];
                                            });
                                          } else {
                                            setState(() {
                                              selectedLevel = "Hard";
                                            });
                                          }
                                        },
                                        icon: Icon(
                                          Icons.arrow_back_ios,
                                          color: Colors.white,
                                        )),
                                    Text(selectedLevel,
                                        style: GoogleFonts.pressStart2p(
                                            textStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize: 25))),
                                    IconButton(
                                        onPressed: () {
                                          try {
                                            _audioCache
                                                .play('change_level.mp3');
                                          } catch (error) {
                                            SystemSound.play(
                                                SystemSoundType.click);
                                          }
                                          if (selectedLevel != "Hard") {
                                            setState(() {
                                              selectedLevel = level[
                                                  level.indexOf(selectedLevel) +
                                                      1];
                                            });
                                          } else {
                                            setState(() {
                                              selectedLevel = "Easy";
                                            });
                                          }
                                        },
                                        icon: Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.white,
                                        )),
                                  ],
                                ),
                                height: 50,
                                width: 250,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Transform.scale(
                        child: Padding(
                            padding: EdgeInsets.only(bottom: 50),
                            child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Stack(
                                  children: <Widget>[
                                    Hero(
                                      createRectTween: (begin, end) {
                                        return RectTween();
                                      },
                                      tag: 'transition',
                                      child: Image.asset(
                                        "assets/controller.png",
                                        width: 300,
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            170, 130, 0, 50),
                                        child: InkWell(
                                          onTap: () {
                                            try {
                                              _audioCache
                                                  .play('button_press.mp3');
                                            } catch (error) {
                                              SystemSound.play(
                                                  SystemSoundType.click);
                                            }
                                            setState(() {
                                              timeinitial = difficultyTime[
                                                  selectedLevel]!;
                                              timeleft = difficultyTime[
                                                  selectedLevel]!;
                                            });
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                PageRouteBuilder(
                                                    transitionDuration:
                                                        Duration(
                                                            milliseconds: 400),
                                                    pageBuilder: (_, __, ___) =>
                                                        Game()),
                                                (route) => false);
                                            // Navigator.pushAndRemoveUntil(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //         builder: (context) => Game()),
                                            //     (route) => false);
                                          },
                                          child: CircleAvatar(
                                            child: Text(
                                              "Play",
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            radius: 15,
                                            backgroundColor:
                                                Color.fromRGBO(251, 90, 72, 1),
                                          ),
                                        ))
                                  ],
                                ))),
                        scale: 1.1,
                        // scaleY: 1.2,
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        }));
  }
}
