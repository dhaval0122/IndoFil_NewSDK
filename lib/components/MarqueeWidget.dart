import 'package:flutter/material.dart';

class MarqueeWidget extends StatefulWidget {
  final Widget child;
  final Axis direction;
  final Duration animationDuration, backDuration, pauseDuration;

  MarqueeWidget({
    required this.child,
    this.direction: Axis.horizontal,
    this.animationDuration: const Duration(milliseconds: 8000),
    this.backDuration: const Duration(milliseconds: 8000),
    this.pauseDuration: const Duration(milliseconds: 800),
  });

  @override
  _MarqueeWidgetState createState() => _MarqueeWidgetState();
}

class _MarqueeWidgetState extends State<MarqueeWidget> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scroll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: widget.child,
      scrollDirection: widget.direction,
      controller: scrollController,
    );
  }

  void scroll() async {
    while (true) {
      await Future.delayed(widget.pauseDuration);
      if (scrollController.hasClients) {
        await scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: widget.animationDuration,
            curve: Curves.easeIn);
      }
      await Future.delayed(widget.pauseDuration);
      await scrollController.animateTo(0.0,
          duration: widget.backDuration, curve: Curves.easeOut);
    }
  }
}
