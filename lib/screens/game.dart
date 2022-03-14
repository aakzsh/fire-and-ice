import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icesicle/animations/cubes.dart';
import 'package:icesicle/screens/gameover.dart';
import 'package:icesicle/screens/result.dart';
import 'package:icesicle/constants/constants.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rive/rive.dart';
import 'package:show_up_animation/show_up_animation.dart';
// import 'package:audioplayers/audio_cache.dart';

class Game extends StatefulWidget {
  const Game({Key? key})
      : super(
          key: key,
        );

  @override
  State<Game> createState() => _GameState();
}

final AudioCache _audioCache = AudioCache(
  prefix: 'audio/',
  fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP),
);

class _GameState extends State<Game> {
  late RiveSceneController control;
  bool isLoaded = false;
  String swapText = "";
  bool swapInProg = false;
  int onTapped = 0;
  int c = 0;
  int swapleft = 2;
  List<int> swapped = [];
  Color bgcolor = Color.fromRGBO(r.toInt(), g.toInt(), b.toInt(), 1);
  checkpos(index) {
    int _24index = pos.indexOf(24);
    if ((index - _24index).abs() == 1) {
      setState(() {
        int x = pos[index];
        pos[index] = pos[_24index];
        pos[_24index] = x;
      });

      if (pos == posCheck) {
        try {
          _audioCache.play('win.mp3');
        } catch (error) {
          SystemSound.play(SystemSoundType.click);
        }
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
        color: Colors.blue.withOpacity(0.02),
      );
    } else if (index == onTapped) {
      Direction dir = Direction.vertical;
      double offset = -2;
      int _24_index = pos.indexOf(24);

      // left to right
      if (index - _24_index == 1) {
        dir = Direction.horizontal;
        offset = -2.5;
      }
      // r to l
      else if (index - _24_index == -1) {
        dir = Direction.horizontal;
        offset = 2.5;
      }
      // b to t
      else if (index - _24_index == -5) {
        dir = Direction.vertical;
        offset = 2.5;
      } else {
        dir = Direction.vertical;
        offset = -2.5;
      }

      return InkWell(
        onTap: () {
          try {
            _audioCache.play('collided.mp3', volume: 0.4);
          } catch (error) {
            SystemSound.play(SystemSoundType.click);
          }
          setState(() {
            onTapped = pos.indexOf(24);
          });
          if (swapInProg) {
            print("hehe");
            print(swapped);
            if (swapped.length < 2) {
              swapped.add(index);
              print(swapped);
            }
            if (swapped.length == 2) {
              setState(() {
                swapText = "";
                int one = pos[swapped[0]];
                int two = pos[swapped[1]];
                pos[swapped[0]] = two;
                pos[swapped[1]] = one;
                swapInProg = false;
                swapped = [];
              });
            }
          } else {
            if ([4, 9, 14, 19, 24].contains(index) &&
                pos.indexOf(24) == index + 1) {
              print("invalid move");
            } else if ([0, 5, 10, 15, 20].contains(index) &&
                pos.indexOf(24) == index - 1) {
              print("invalid move");
            } else {
              checkpos(index);
            }
          }
        },
        child: ShowUpAnimation(
          direction: dir,
          offset: offset,
          curve: Curves.easeOut,
          animationDuration: Duration(milliseconds: 250),
          child: Opacity(
            opacity: 1.0,
            child: Container(
              child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Center(
                      child: Stack(children: <Widget>[
                    Image.asset('assets/ice.png'),
                    Center(
                        child: Text(
                      (pos[index] + 1).toString(),
                      style: TextStyle(
                          color: Color(0xff1C767B),
                          fontWeight: FontWeight.w600,
                          fontSize: 24.0),
                    ))
                  ]))),
            ),
          ),
        ),
      );
    }
    return InkWell(
      onTap: () {
        try {
          _audioCache.play('collided.mp3', volume: 0.4);
        } catch (error) {
          SystemSound.play(SystemSoundType.click);
        }
        setState(() {
          onTapped = pos.indexOf(24);
        });
        if (swapInProg) {
          print("hehe");
          print(swapped);
          if (swapped.length < 2) {
            swapped.add(index);
            print(swapped);
          }
          if (swapped.length == 2) {
            setState(() {
              int one = pos[swapped[0]];
              int two = pos[swapped[1]];
              pos[swapped[0]] = two;
              pos[swapped[1]] = one;
              swapInProg = false;
              swapped = [];
            });
          }
        } else {
          if ([4, 9, 14, 19, 24].contains(index) &&
              pos.indexOf(24) == index + 1) {
            print("invalid move");
          } else if ([0, 5, 10, 15, 20].contains(index) &&
              pos.indexOf(24) == index - 1) {
            print("invalid move");
          } else {
            checkpos(index);
          }
        }
      },
      // child: HoverX(
      //   title: "x",
      //   hoverColor: Colors.blueAccent,
      //   image: NetworkImage(
      //       "https://cdn.discordapp.com/emojis/862226603715067946.webp"),
      // )
      child: Opacity(
        opacity: 1.0,
        child: Container(
          child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Center(
                  child: Stack(children: <Widget>[
                Image.asset('assets/ice.png'),
                Center(
                    child: Text(
                  (pos[index] + 1).toString(),
                  style: TextStyle(
                      color: Color(0xff1C767B),
                      fontWeight: FontWeight.w600,
                      fontSize: 24.0),
                ))
              ]))),
        ),
      ),
    );
  }

  timerStart() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        c++;
        r += ((fr - sr) / timeinitial);
        g += ((fg - sg) / timeinitial);
        b += ((fb - sb) / timeinitial);
        bgcolor = Color.fromRGBO(r.toInt(), g.toInt(), b.toInt(), 1);

        timeleft--;
      });
      if (c == 0) {
        setState(() {
          r = 10;
          g = 41;
          b = 61;
        });
      }
      if (c == 4) {
        setState(() {
          isLoaded = true;
        });
      }

      if (timeleft == 0) {
        try {
          _audioCache.play('game_over.mp3');
        } catch (error) {
          SystemSound.play(SystemSoundType.click);
        }
        timer.cancel();
        setState(() {
          message = "Awh damn";
          bottommsg = "best of luck next time!";
        });
        // this.timerStart()

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => GameOver()),
            (route) => false);
      }
    });
  }

  keyPressed(val) {
    // SystemSound.play(SystemSoundType.click);
    setState(() {
      onTapped = pos.indexOf(24);
    });
    if (val == "4294968068") {
      try {
        _audioCache.play('collided.mp3');
      } catch (error) {
        SystemSound.play(SystemSoundType.click);
      }

      if (pos.indexOf(24) <= 24) {
        checkpos(pos.indexOf(24) + 5);
      }
    } else if (val == "4294968066") {
      try {
        _audioCache.play('collided.mp3');
      } catch (error) {
        SystemSound.play(SystemSoundType.click);
      }

      if (![4, 9, 14, 19, 24].contains(pos.indexOf(24))) {
        checkpos(pos.indexOf(24) + 1);
      }
    } else if (val == "4294968067") {
      try {
        _audioCache.play('collided.mp3');
      } catch (error) {
        SystemSound.play(SystemSoundType.click);
      }

      if (![0, 5, 10, 15, 20].contains(pos.indexOf(24))) {
        checkpos(pos.indexOf(24) - 1);
      }
    } else if (val == "4294968065") {
      try {
        _audioCache.play('collided.mp3');
      } catch (error) {
        SystemSound.play(SystemSoundType.click);
      }

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
    setState(() {
      r = 10;
      g = 41;

      b = 61;
    });
    timerStart();
    super.initState();
  }

  String x = "lol";
  final FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    // pos.shuffle();
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return RawKeyboardListener(
      focusNode: _focusNode,
      onKey: ((RawKeyEvent event) {
        print(event.logicalKey.keyId);
        if (event is RawKeyDownEvent) {
          keyPressed(event.logicalKey.keyId.toString());

          if (pos.toString() == posCheck.toString()) {
            setState(() {
              message = "Well Done!";
              time = timeinitial - timeleft;
              bottommsg = "You've completed the level in $time seconds";
              r = 10;
              g = 41;
              b = 61;
            });
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Result()));
            print("won!!!");
          }
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
            body: Stack(children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                child: SvgPicture.asset(
                  'assets/water.svg',
                  fit: BoxFit.cover,
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Image.asset(
                  'assets/island.png',
                  width: w / 3,
                ),
              ),
              Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: bgcolor.withOpacity(0.6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Stack(
                        alignment: Alignment.topCenter,
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Tooltip(
                                child: Container(
                                  height: 300,
                                  width: 300,
                                  child: RiveAnimation.asset(
                                    "assets/$timeinitial.riv",
                                  ),
                                ),
                                message:
                                    "solve the puzzle before its sunny enough for the ice to melt down",
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.all(0),
                                showDuration: Duration(milliseconds: 100),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 224, 218, 218),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(4)),
                                ),
                                textStyle: TextStyle(color: Color(0xff1C767B)),
                                preferBelow: true,
                                verticalOffset: -80,
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: 200,
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(238, 200, 93, 1),
                                      borderRadius: BorderRadius.circular(10)),
                                  height: 100,
                                  width: 150,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "$timeleft",
                                        style: TextStyle(
                                            fontSize: 30, color: Colors.black),
                                      ),
                                      Text("sec left",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black))
                                    ],
                                  )),
                              SizedBox(
                                height: 70,
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(238, 200, 93, 1),
                                      borderRadius: BorderRadius.circular(10)),
                                  height: 100,
                                  width: 150,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "$swapleft",
                                        style: TextStyle(
                                            fontSize: 30, color: Colors.black),
                                      ),
                                      Text("swaps left",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black))
                                    ],
                                  ))
                            ],
                          )
                        ],
                      ),
                      Hero(
                        tag: 'transition',
                        child: Container(
                          height: h - 100,
                          width: h - 100,
                          decoration: BoxDecoration(
                              color: Color(0xff2ED2DB),
                              borderRadius: BorderRadius.circular(25.0)),
                          // color: Colors.pinkAccent,
                          child: isLoaded
                              ? Padding(
                                  padding: EdgeInsets.all(20),
                                  child: GridView.count(
                                      crossAxisCount: 5,
                                      children: List.generate(25, (index) {
                                        return Padding(
                                            padding: EdgeInsets.all(4),
                                            child: retWidget(index));
                                      })))
                              : cubes(),
                        ),
                      ),
                      Container(
                          decoration: BoxDecoration(
                              // color: Color.fromRGBO(238, 200, 93, 1),
                              color: Color(0xff2ED2DB).withOpacity(1),
                              borderRadius: BorderRadius.circular(10)),
                          height: 120,
                          width: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              MaterialButton(
                                onPressed: () {
                                  if (swapleft > 0) {
                                    setState(() {
                                      swapInProg = true;
                                      swapText =
                                          "now choose two tiles you wanna swap";
                                      swapleft--;
                                    });
                                  } else {
                                    setState(() {
                                      swapText = "youve used all your swaps";
                                    });
                                  }

                                  // useSwap();
                                },
                                child: Text("use swap",
                                    style: TextStyle(
                                        fontSize: 32,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500)),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: Text("$swapText",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black.withOpacity(0.7))),
                              )
                              // Text("$swapText"),
                            ],
                          ))
                    ],
                  )),
            ]),
          );
        },
      ),
    );
  }
}
