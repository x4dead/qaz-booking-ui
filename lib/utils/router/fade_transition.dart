import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FadeTransitionPage extends CustomTransitionPage<void> {
  final bool? isInstantEffect;
  FadeTransitionPage({
    required LocalKey super.key,
    required super.child,
    this.isInstantEffect = false,
  }) : super(transitionsBuilder: (BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child) {
          if (isInstantEffect == true) {
            return child;
          } else {
            return FadeTransition(
              opacity: animation.drive(_curveTween),
              child: child,
            );
          }
        });

  static final CurveTween _curveTween = CurveTween(curve: Curves.easeOut);
}
