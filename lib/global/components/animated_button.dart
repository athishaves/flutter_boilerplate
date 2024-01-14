import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedButtonContainer extends StatefulWidget {
  final Function onPressed;
  final Duration duration;
  final bool disabled;
  final Widget child;
  const AnimatedButtonContainer({
    super.key,
    required this.onPressed,
    this.disabled = false,
    this.duration = const Duration(milliseconds: 100),
    required this.child,
  });

  @override
  State<AnimatedButtonContainer> createState() =>
      _AnimatedButtonContainerState();
}

class _AnimatedButtonContainerState extends State<AnimatedButtonContainer>
    with SingleTickerProviderStateMixin {
  bool _disabled = false;
  late AnimationController _controller;
  Completer? _completer;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future animate() async {
    _completer = Completer();
    _controller.value = 0.0;
    _controller.animateTo(1.0);
    await Future.delayed(widget.duration);
    _controller.animateTo(0.0);
    _completer!.complete(true);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (widget.disabled || _disabled) {
          return;
        }
        _disabled = true;

        animate();
        widget.onPressed();
        await _completer?.future;

        _disabled = false;
      },
      child: widget.child
          .animate(controller: _controller, autoPlay: false)
          .scaleXY(begin: 1.0, end: 0.9)
          .fade(begin: 1.0, end: 0.5)
          .then()
          .scaleXY(begin: 0.9, end: 1.0)
          .fade(begin: 0.5, end: 1.0),
    );
  }
}
