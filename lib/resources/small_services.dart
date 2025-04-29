import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget showSvg(String path, {double height = 100, double width = 100}) {
  return SvgPicture.asset(
    path,
    height: height,
    width: width,
  );
}