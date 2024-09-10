import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'configs.dart';

unFocus(BuildContext context){
  FocusScope.of(context).unfocus();
}

Widget svgIcon(String name, {double size = 26, Color? color}) {
  return SvgPicture.asset(
    assetIcon(name, format: "svg"),
    width: size,
    height: size,
   // color: color ?? Colors.black,  // Default color in case color is not provided
  );
}

String assetIcon(String iconName, {String format = "png"}) {
  String path = ASSETS_ICONS_PATH + "$iconName.$format";
  print('Loading icon from: $path');  // Debugging line
  return path;
}



void back<T extends Object?>(BuildContext context, [T? result]) {
  try {
    if (!Navigator.canPop(context)) return;
    Navigator.pop<T>(context, result);
  } catch (e) {
    return;
  }
}

void backToHome(BuildContext context) {
  Navigator.of(context).popUntil((route) => route.isFirst);
}

Future<T?> push<T extends Object?>(BuildContext context, Widget screen, {bool defaultPageRoute = false, String? name}) {
  return Navigator.push<T>(
    context,
    defaultPageRoute
        ? MaterialPageRoute(builder: (_) => screen)
        : PageRouteBuilder(
      pageBuilder: (_, __, ___) => screen,
      barrierLabel: (screen).toString(),
      transitionDuration: Duration(milliseconds: 120),
      reverseTransitionDuration: Duration(milliseconds: 120),
      transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
      settings: RouteSettings(name: name),
    ),
  );
}

PageRoute generateRouteWithAnimation(Widget screen, {String? name}) {
  return PageRouteBuilder(
    pageBuilder: (_, __, ___) => screen,
    barrierLabel: (screen).toString(),
    transitionDuration: Duration(milliseconds: 120),
    reverseTransitionDuration: Duration(milliseconds: 120),
    transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
    settings: RouteSettings(name: name),
  );
}

Future<T?> pushReplacement<T extends Object?, TO extends Object?>(BuildContext context, Widget screen, {TO? result, String? name}) {
  return Navigator.pushReplacement<T, TO>(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => screen,
        barrierLabel: (screen).toString(),
        transitionDuration: Duration(milliseconds: 120),
        reverseTransitionDuration: Duration(milliseconds: 120),
        transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
        settings: RouteSettings(name: name),
      ),
      result: result);
}

Future<T?> pushAndRemoveUntil<T extends Object?>(BuildContext context, Widget screen, RoutePredicate predicate) {
  return Navigator.pushAndRemoveUntil<T>(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => screen,
        barrierLabel: (screen).toString(),
        transitionDuration: Duration(milliseconds: 120),
        reverseTransitionDuration: Duration(milliseconds: 120),
        transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
      ),
      predicate);
}
dynamic jDecode(String json) {
  return jsonDecode(convertUtf8(json));
}String convertUtf8(String content) {
  return Utf8Decoder(allowMalformed: true).convert(content.codeUnits);
}
