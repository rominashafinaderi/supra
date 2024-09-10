import 'package:flutter/cupertino.dart';

extension IntExtention on int? {
  int validate({int value = 0}) {
    return this ?? value;
  }

  Widget get height => SizedBox(
    height: this?.toDouble(),
  );

  Widget get width => SizedBox(
    width: this?.toDouble(),
  );
}