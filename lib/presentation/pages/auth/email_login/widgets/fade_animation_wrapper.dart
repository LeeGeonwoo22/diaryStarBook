import 'package:flutter/material.dart';


class FadeAnimationWrapper extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;

  FadeAnimationWrapper({super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 800),
    this.curve = Curves.easeIn,
  });
  State<FadeAnimationWrapper> createState() => _FadeAnimationWrapperState();
}

class _FadeAnimationWrapperState extends State<FadeAnimationWrapper> with SingleTickerProviderStateMixin{
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: widget.child,
    );
  }
}
