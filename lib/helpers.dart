import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

unFocus(BuildContext context){
  FocusScope.of(context).unfocus();
}

// Widget svgIcon(String name, {double size = 26, Color? color}) {
//   return SvgPicture.asset(
//     assetIcon(name, format: "svg"),
//     width: size,
//     height: size,
//     color: color,
//   );
// }String assetIcon(String iconName, {String format = "png"}) {
//   return ASSETS_ICONS_PATH + "$iconName.$format";
// }