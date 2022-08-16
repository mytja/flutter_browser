import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GuineaSVG extends StatelessWidget {
  const GuineaSVG({Key? key, required this.svg}) : super(key: key);

  final String svg;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.string(svg);
  }
}
