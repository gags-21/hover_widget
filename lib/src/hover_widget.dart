/// {@template hover_widget}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
library;
// class HoverWidget {
//   /// {@macro hover_widget}
//   const HoverWidget();
// }

import 'dart:async';

import 'package:flutter/material.dart';

class HoverWidget extends StatefulWidget {
  /// {@macro hover_widget}
  const HoverWidget({
    required this.child,
    this.onTap,
    super.key,
  });

  final Widget child;
  final Function? onTap;

  @override
  _HoverWidgetState createState() => _HoverWidgetState();
}

class _HoverWidgetState extends State<HoverWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double widgetScale = 1;
  double hoverScale = 1;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 50,
      ),
      lowerBound: .9,
      // upperBound: 1,
      value: 1,
    )..addListener(() {
        setState(() {
          widgetScale = _controller.value;
        });
      });
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
        setState(() => hoverScale = 1.2);
        // _controller.forward(from: 1);
      },
      onExit: (f) {
        setState(() => hoverScale = 1);
        // _controller.reverse();
      },
      child: Listener(
        onPointerDown: (event) async {
          await _controller.reverse();
        },
        onPointerUp: (event) async {
          Timer(const Duration(milliseconds: 150), () {
            _controller.forward();
          });
          if (widget.onTap != null) {
           widget.onTap!();
          }
        },
        child: Transform.scale(
          scale: widgetScale,
          child: AnimatedScale(
            scale: hoverScale,
            curve: Curves.bounceInOut,
            duration: const Duration(milliseconds: 100),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
