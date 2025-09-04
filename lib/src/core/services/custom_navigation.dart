import 'package:sol_replace_revamp/src/core/globals/variables.dart';
import 'package:flutter/material.dart';

class CustomNavigation {
  static final CustomNavigation _instance = CustomNavigation._internal();

  factory CustomNavigation() {
    return _instance;
  }

  CustomNavigation._internal();

  GlobalKey<NavigatorState> get _navigatorKey => materialAppKey;

  Future<dynamic> push(
    Widget page, {
    bool animate = true,
    AxisDirection direction = AxisDirection.left,
    int milliseconds = routingDuration,
  }) async {
    return await Navigator.of(_navigatorKey.currentContext!).push(
      RoutingAnimation(
        child: page,
        animate: animate,
        direction: direction,
        milliseconds: milliseconds,
      ),
    );
  }

  Future<dynamic> pushReplacement(
    Widget page, {
    bool animate = true,
    AxisDirection direction = AxisDirection.left,
    int milliseconds = routingDuration,
  }) async {
    return await Navigator.of(_navigatorKey.currentContext!).pushReplacement(
      RoutingAnimation(
        child: page,
        animate: animate,
        direction: direction,
        milliseconds: milliseconds,
      ),
    );
  }

  Future<dynamic> pushAndRemoveUntil(
    Widget page, {
    bool animate = true,
    AxisDirection direction = AxisDirection.left,
    int milliseconds = routingDuration,
  }) async {
    return await Navigator.of(_navigatorKey.currentContext!).pushAndRemoveUntil(
      RoutingAnimation(
        child: page,
        animate: animate,
        direction: direction,
        milliseconds: milliseconds,
      ),
      (Route<dynamic> route) => false,
    );
  }

  void pop<T extends Object>([T? result]) {
    return Navigator.of(_navigatorKey.currentContext!).pop<T>(result);
  }

  void popUntil(Widget page) {
    Navigator.of(
      _navigatorKey.currentContext!,
    ).popUntil((route) => route.settings.name == page.runtimeType.toString());
  }
}

class RoutingAnimation extends PageRouteBuilder {
  final Widget child;
  final AxisDirection direction;
  final bool animate;
  final int milliseconds;

  RoutingAnimation({
    required this.direction,
    required this.animate,
    required this.child,
    required this.milliseconds,
  }) : super(
         transitionDuration: Duration(milliseconds: milliseconds),
         pageBuilder: (context, animation, secondaryAnimation) => child,
         settings: RouteSettings(name: child.runtimeType.toString()),
       );

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (animate) {
      // Check the animate parameter here
      return SlideTransition(
        position: Tween<Offset>(
          begin: getBeginOffset(),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
    } else {
      return child; // Return the child widget without animation
    }
  }

  Offset getBeginOffset() {
    switch (direction) {
      case AxisDirection.up:
        return const Offset(0, 1);
      case AxisDirection.down:
        return const Offset(0, -1);
      case AxisDirection.right:
        return const Offset(-1, 0);
      case AxisDirection.left:
        return const Offset(1, 0);
    }
  }
}
