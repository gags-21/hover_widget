import 'dart:async';
import 'package:flutter/material.dart';

/// main class
class HoverWidget extends StatefulWidget {
  /// {@macro hover_widget}
  const HoverWidget({
    required this.child,
    this.onTap,
    super.key,
  });

  /// widget to be wrapped
  final Widget child;

  /// optional onTap functionality
  final void Function()? onTap;

  @override
  HoverWidgetState createState() => HoverWidgetState();
}

/// main state
class HoverWidgetState extends State<HoverWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  /// observe user taps
  double widgetScale = 1;

  /// observe user hover
  double hoverScale = 1;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 50,
      ),
      lowerBound: .9,
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
      },
      onExit: (f) {
        setState(() => hoverScale = 1);
      },
      child: Listener(
        onPointerDown: (event) async {
          await _controller.reverse();
        },
        onPointerUp: (event) async {
          Timer(const Duration(milliseconds: 150), () {
            _controller.forward();
          });
          widget.onTap?.call();
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
