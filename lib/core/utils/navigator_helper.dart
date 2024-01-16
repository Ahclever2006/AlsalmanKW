import 'package:flutter/material.dart';

class NavigatorHelper extends Navigator {
  final BuildContext context;
  final bool rootNavigator;
  const NavigatorHelper._internal(
    this.context, {
    required this.rootNavigator,
  });
  static NavigatorHelper of(
    BuildContext context, {
    bool rootNavigator = false,
  }) {
    return NavigatorHelper._internal(context, rootNavigator: rootNavigator);
  }

  @optionalTypeArgs
  Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.clearSnackBars();
    return Navigator.of(context).pushNamed<T>(routeName, arguments: arguments);
  }

  @optionalTypeArgs
  String restorablePushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.clearSnackBars();
    return Navigator.of(context)
        .restorablePushNamed<T>(routeName, arguments: arguments);
  }

  @optionalTypeArgs
  Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.clearSnackBars();
    return Navigator.of(context).pushReplacementNamed<T, TO>(routeName,
        arguments: arguments, result: result);
  }

  @optionalTypeArgs
  String restorablePushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.clearSnackBars();
    return Navigator.of(context).restorablePushReplacementNamed<T, TO>(
        routeName,
        arguments: arguments,
        result: result);
  }

  @optionalTypeArgs
  Future<T?> popAndPushNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.clearSnackBars();
    return Navigator.of(context).popAndPushNamed<T, TO>(routeName,
        arguments: arguments, result: result);
  }

  @optionalTypeArgs
  String restorablePopAndPushNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.clearSnackBars();
    return Navigator.of(context).restorablePopAndPushNamed<T, TO>(routeName,
        arguments: arguments, result: result);
  }

  @optionalTypeArgs
  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    String newRouteName,
    RoutePredicate predicate, {
    Object? arguments,
  }) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.clearSnackBars();
    return Navigator.of(context).pushNamedAndRemoveUntil<T>(
        newRouteName, predicate,
        arguments: arguments);
  }

  @optionalTypeArgs
  String restorablePushNamedAndRemoveUntil<T extends Object?>(
    String newRouteName,
    RoutePredicate predicate, {
    Object? arguments,
  }) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.clearSnackBars();
    return Navigator.of(context).restorablePushNamedAndRemoveUntil<T>(
        newRouteName, predicate,
        arguments: arguments);
  }

  @optionalTypeArgs
  Future<T?> push<T extends Object?>(Route<T> route) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.clearSnackBars();
    return Navigator.of(context).push(route);
  }

  @optionalTypeArgs
  String restorablePush<T extends Object?>(
      RestorableRouteBuilder<T> routeBuilder,
      {Object? arguments}) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.clearSnackBars();
    return Navigator.of(context)
        .restorablePush(routeBuilder, arguments: arguments);
  }

  @optionalTypeArgs
  Future<T?> pushReplacement<T extends Object?, TO extends Object?>(
      Route<T> newRoute,
      {TO? result}) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.clearSnackBars();
    return Navigator.of(context)
        .pushReplacement<T, TO>(newRoute, result: result);
  }

  @optionalTypeArgs
  String restorablePushReplacement<T extends Object?, TO extends Object?>(
      RestorableRouteBuilder<T> routeBuilder,
      {TO? result,
      Object? arguments}) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.clearSnackBars();
    return Navigator.of(context).restorablePushReplacement<T, TO>(routeBuilder,
        result: result, arguments: arguments);
  }

  @optionalTypeArgs
  Future<T?> pushAndRemoveUntil<T extends Object?>(
      Route<T> newRoute, RoutePredicate predicate) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.clearSnackBars();
    return Navigator.of(context).pushAndRemoveUntil<T>(newRoute, predicate);
  }

  @optionalTypeArgs
  String restorablePushAndRemoveUntil<T extends Object?>(
      RestorableRouteBuilder<T> newRouteBuilder, RoutePredicate predicate,
      {Object? arguments}) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.clearSnackBars();
    return Navigator.of(context).restorablePushAndRemoveUntil<T>(
        newRouteBuilder, predicate,
        arguments: arguments);
  }

  @optionalTypeArgs
  void replace<T extends Object?>(
      {required Route<dynamic> oldRoute, required Route<T> newRoute}) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.clearSnackBars();
    return Navigator.of(context)
        .replace<T>(oldRoute: oldRoute, newRoute: newRoute);
  }

  @optionalTypeArgs
  String restorableReplace<T extends Object?>(
      {required Route<dynamic> oldRoute,
      required RestorableRouteBuilder<T> newRouteBuilder,
      Object? arguments}) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.clearSnackBars();
    return Navigator.of(context).restorableReplace<T>(
        oldRoute: oldRoute,
        newRouteBuilder: newRouteBuilder,
        arguments: arguments);
  }

  @optionalTypeArgs
  void replaceRouteBelow<T extends Object?>(
      {required Route<dynamic> anchorRoute, required Route<T> newRoute}) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.clearSnackBars();
    return Navigator.of(context)
        .replaceRouteBelow<T>(anchorRoute: anchorRoute, newRoute: newRoute);
  }

  @optionalTypeArgs
  String restorableReplaceRouteBelow<T extends Object?>(
      {required Route<dynamic> anchorRoute,
      required RestorableRouteBuilder<T> newRouteBuilder,
      Object? arguments}) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.clearSnackBars();
    return Navigator.of(context).restorableReplaceRouteBelow<T>(
        anchorRoute: anchorRoute,
        newRouteBuilder: newRouteBuilder,
        arguments: arguments);
  }

  bool canPop() {
    final NavigatorState? navigator = Navigator.maybeOf(context);
    return navigator != null && navigator.canPop();
  }

  @optionalTypeArgs
  Future<bool> maybePop<T extends Object?>([T? result]) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.clearSnackBars();
    return Navigator.of(context).maybePop<T>(result);
  }

  @optionalTypeArgs
  void pop<T extends Object?>([T? result]) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.clearSnackBars();
    Navigator.of(context).pop<T>(result);
  }

  void popUntil(RoutePredicate predicate) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.clearSnackBars();
    Navigator.of(context).popUntil(predicate);
  }

  void removeRoute(Route<dynamic> route) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.clearSnackBars();
    return Navigator.of(context).removeRoute(route);
  }

  void removeRouteBelow(Route<dynamic> anchorRoute) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.clearSnackBars();
    return Navigator.of(context).removeRouteBelow(anchorRoute);
  }
}
