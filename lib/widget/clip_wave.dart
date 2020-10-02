import 'dart:math';


import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart'
    as clipPack;


class ClipWaveTwoSide extends StatelessWidget {
  final Widget child;
  final Color color;
  final double height;
  const ClipWaveTwoSide(
      {Key key,
      @required this.child,
      this.color = Colors.white,
      this.height = 140})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height + 105,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: ClipPath(
              clipper: clipPack.WaveClipperOne(reverse: true),
              // boxShadow: [
              //   BoxShadow(
              //       color: color,
              //       blurRadius: 100,
              //       spreadRadius: 5,
              //       offset: Offset(5, -10))
              // ],
              child: Container(
                
                height: 55,
                color: color,
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Transform(
              transform: Matrix4.rotationY(pi),
              alignment: Alignment.center,
              child: ClipPath(
                clipper: clipPack.WaveClipperOne(),
                // boxShadow: [
                //   BoxShadow(
                //       color: color,
                //       blurRadius: 100,
                //       spreadRadius: 5,
                //       offset: Offset(-5, 10))
                // ],
                child: Container(
                  height: 55,
                  color: color,
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
                color: color,
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                height: height,
                width: double.maxFinite,
                child: child),
          ),
        ],
      ),
    );
  }
}
