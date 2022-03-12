import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
//import wave package

//set this class to home: attribute of MaterialApp() at main.dart
class MyWave extends StatefulWidget {
  const MyWave({Key? key}) : super(key: key);

  @override
  State<MyWave> createState() => _MyWaveState();
}

class _MyWaveState extends State<MyWave> {
  double x = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          color: Colors.blueAccent,
          child: WaveWidget(
            //user Stack() widget to overlap content and waves
            config: CustomConfig(
              colors: [
                Colors.purple.withOpacity(0.2),
                Colors.deepPurpleAccent.withOpacity(0.2),
                Colors.purple.withOpacity(0.2),
                Colors.deepPurpleAccent.withOpacity(0.2),
                Colors.purple.withOpacity(0.2),
                //the more colors here, the more wave will be
              ],
              durations: [8000, 10000, 14000, 9000, 4500],
              //durations of animations for each colors,
              // make numbers equal to numbers of colors
              heightPercentages: [0.01, 0.05, 0.45, 0.65, 0.85],
              //height percentage for each colors.
              blur: MaskFilter.blur(BlurStyle.solid, 5),
              //blur intensity for waves
            ),
            waveAmplitude: 35.00, //depth of curves
            waveFrequency: 3, //number of curves in waves
            backgroundColor: Colors.blueAccent[200], //background colors
            size: Size(
              double.infinity,
              double.infinity,
            ),
          ),
        ),
      ],
    ));
  }
}
