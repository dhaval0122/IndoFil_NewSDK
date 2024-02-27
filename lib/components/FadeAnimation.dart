import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  FadeAnimation(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTween()
      ..add(Duration(milliseconds: 500), Tween(begin: 0.0, end: 1.0))
      ..add(Duration(milliseconds: 700), Tween(begin: -30.0, end: 0.0),
          Duration(milliseconds: 700), Curves.easeOut);

    return PlayAnimation<MultiTweenValues>(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builder: (context, child, dynamic animation) => Opacity(
        opacity: animation["opacity"],
        child: Transform.translate(
            offset: Offset(0, animation["translateY"]), child: child),
      ),
    );
  }
}
