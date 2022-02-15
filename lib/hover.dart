library hover;

import 'package:flutter/material.dart';

class ButtonFeedback extends StatefulWidget {
  const ButtonFeedback({Key? key, required this.child}) : super(key: key);

  final Widget child;
  // final Function onTap;

  @override
  _ButtonFeedbackState createState() => _ButtonFeedbackState();
}

class _ButtonFeedbackState extends State<ButtonFeedback>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      animationBehavior: AnimationBehavior.normal,
      duration: const Duration(
        milliseconds: 100,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (f) {
        _controller.reverse();
      },
      onExit: (f) {
        _controller.forward();
      },
      child: GestureDetector(
        onTap: () {
          // widget.onTap();
        },
        onTapDown: (value) {
          _controller.forward();
        },
        onTapUp: (value) {
          _controller.reverse();
        },
        onTapCancel: () {
          _controller.reverse();
        },
        child: Transform.scale(
          scale: 1 - _controller.value,
          child: widget.child,
        ),
      ),
    );
  }
}
