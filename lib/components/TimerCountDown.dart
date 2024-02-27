import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Countdown extends AnimatedWidget {
  Countdown({Key? key, required this.animation}) : super(key: key, listenable: animation);
  Animation<int> animation;

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);

    String timerText =
        '${clockTimer.inMinutes.remainder(60).toString()}:${(clockTimer.inSeconds.remainder(60) % 60).toString().padLeft(2, '0')}';

    return Text(
      "$timerText",
      style: TextStyle(
        fontSize: 25,
        color: Colors.black87,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
