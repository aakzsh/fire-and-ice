import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icesicle/screens/gameover.dart';
import 'package:icesicle/screens/result.dart';
import 'package:icesicle/constants/constants.dart';
import 'package:audioplayers/audioplayers.dart';
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

class _GameState extends State<Game> {
  final AudioCache _audioCache = AudioCache(
    prefix: 'audio/',
    fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP),
  );
  String swapText = "";
  bool swapInProg = false;
  int onTapped = 0;

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
        child: ShowUpAnimation(
          direction: dir,
          offset: offset,
          curve: Curves.easeOut,
          animationDuration: Duration(milliseconds: 250),
          child: Opacity(
            opacity: 1.0,
            child: Container(
              child: Padding(
                  padding: const EdgeInsets.all(5.0),
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
              padding: const EdgeInsets.all(5.0),
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
        r += ((fr - sr) / timeinitial);
        g += ((fg - sg) / timeinitial);
        b += ((fb - sb) / timeinitial);
        bgcolor = Color.fromRGBO(r.toInt(), g.toInt(), b.toInt(), 1);

        timeleft--;
      });

      if (timeleft == 0) {
        timer.cancel();
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
    _audioCache.play('collided.mp3');
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
    timerStart();
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

          if (pos.toString() == posCheck.toString()) {
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
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  setState(() {
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
                color: bgcolor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 100,
                      width: 200,
                      child: Text(
                        "$timeleft",
                        style: TextStyle(fontSize: 40, color: Colors.white),
                      ),
                    ),
                    Container(
                      // color: Colors.blueAccent,
                      height: h - 100,
                      width: h - 100,
                      // color: Colors.pinkAccent,
                      child: GridView.count(
                          crossAxisCount: 5,
                          children: List.generate(25, (index) {
                            return Padding(
                                padding: EdgeInsets.all(4),
                                child: retWidget(index));
                          })),
                    ),
                    Container(
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
                                      fontSize: 40, color: Colors.white)),
                            ),
                            Text("$swapleft swaps left",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white)),
                            Text("$swapText"),
                          ],
                        ))
                  ],
                )),
          );
        },
      ),
    );
  }
}
