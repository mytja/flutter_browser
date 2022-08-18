import 'package:flutter/material.dart';
import 'package:flutter_browser/widgets/cssdefinitions.dart';
import 'package:flutter_browser/widgets/htmldefinitions.dart';

class CSSOptions {
  CSSOptions(
    this.css, {
    this.height,
    this.textStyle = const TextStyle(),
    this.verticallyCenter = false,
    this.top = 0,
    this.borderColor = "",
  });

  List css;

  TextStyle textStyle;
  int? height;
  int? top;
  bool verticallyCenter;
  String borderColor;

  CSSOptions cloneObject() {
    return CSSOptions(
      css,
      height: height,
      textStyle: textStyle.copyWith(),
      verticallyCenter: verticallyCenter,
    );
  }
}

CSSOptions mapCSS(BuildContext context, Map c, CSSOptions cssOpts) {
  for (var p in c["properties"]) {
    switch (p["name"]) {
      case COLOR:
        String color = p["value"].replaceAll('#', '0xff');
        int? hexColor = int.tryParse(color);
        if (hexColor == null) {
          continue;
        }
        cssOpts.textStyle = cssOpts.textStyle.merge(
          TextStyle(
            color: Color(hexColor),
          ),
        );
        continue;
      case FONT_SIZE:
        if (p["value"].contains("px")) {
          String size = p["value"].replaceAll('px', '');
          double? pxSize = double.tryParse(size);
          if (pxSize == null) {
            continue;
          }
          cssOpts.textStyle = cssOpts.textStyle.merge(
            TextStyle(
              fontSize: pxSize,
            ),
          );
        } else if (p["value"].contains("%")) {
          String size = p["value"].replaceAll('%', '');
          double? percentSize = double.tryParse(size);
          if (percentSize == null) {
            continue;
          }
          cssOpts.textStyle = cssOpts.textStyle.merge(
            TextStyle(
              fontSize: (percentSize / 100) * 18,
            ),
          );
        } else if (p["value"].contains("em")) {
          String size = p["value"].replaceAll('em', '');
          double? emSize = double.tryParse(size);
          if (emSize == null) {
            continue;
          }
          cssOpts.textStyle = cssOpts.textStyle.merge(
            TextStyle(
              fontSize: emSize * 18,
            ),
          );
        }

        continue;
      case HEIGHT:
        if (p["value"].contains("px")) {
          String size = p["value"].replaceAll('px', '');
          int? pxSize = int.tryParse(size);
          if (pxSize == null) {
            continue;
          }
          cssOpts.height = pxSize;
        } else if (p["value"].contains("em")) {
          String size = p["value"].replaceAll('em', '');
          double? emSize = double.tryParse(size);
          if (emSize == null) {
            continue;
          }
          //debugPrint("em size $size");
          cssOpts.height = (emSize * 18).toInt();
        }
        continue;
      case POSITION:
        if (p["value"] == "relative") cssOpts.verticallyCenter = true;
        continue;
      case BORDER_COLOR:
        String color = p["value"].replaceAll('#', '0xff');
        int? hexColor = int.tryParse(color);
        if (hexColor == null) {
          continue;
        }
        cssOpts.borderColor = color;
        continue;
      case FONT_WEIGHT:
        if (p["value"] == "bold") {
          cssOpts.textStyle = cssOpts.textStyle.merge(Bold);
        }
        continue;
      default:
        continue;
    }
  }
  return cssOpts;
}
