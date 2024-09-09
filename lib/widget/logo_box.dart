import 'package:flutter/material.dart';

import '../helpers.dart';

Widget logoBox(String iconName) {
  return Container(
      height: 40,
      width: 40,
      padding: EdgeInsets.all(7),
      decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 2)],
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)),
      child: svgIcon(iconName, size: 5));
}
