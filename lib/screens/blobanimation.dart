import 'package:flutter/material.dart';
import 'package:icesicle/animations/cubes.dart';
import 'package:icesicle/animations/mascot.dart';
import 'package:just_audio/just_audio.dart';

class Blob extends StatefulWidget {
  const Blob({Key? key}) : super(key: key);

  @override
  State<Blob> createState() => _BlobState();
}

AudioPlayer player = AudioPlayer();

class _BlobState extends State<Blob> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: Mascot()),
    );
  }
}
