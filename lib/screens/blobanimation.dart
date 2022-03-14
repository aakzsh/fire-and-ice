import 'package:flutter/material.dart';
import 'package:icesicle/animations/mascot.dart';

class Blob extends StatefulWidget {
  const Blob({Key? key}) : super(key: key);

  @override
  State<Blob> createState() => _BlobState();
}

class _BlobState extends State<Blob> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: Mascot),
    );
  }
}
