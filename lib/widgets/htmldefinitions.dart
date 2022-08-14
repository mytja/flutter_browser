import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

const H1 = "h1";
const H2 = "h2";
const H3 = "h3";
const H4 = "h4";
const H5 = "h5";
const H6 = "h6";
const BR = "br";
const A = "a";
const HTML = "html";
const BODY = "body";
const HEAD = "head";
const DIV = "div";
const P = "p";
const HEADER = "header";
const FOOTER = "footer";
const ARTICLE = "article";
const MAIN = "main";
const SECTION = "section";
const TEXT = "text";
const TITLE = "title";
const META = "meta";
const IMG = "img";
const CODE = "code";
const PRE = "pre";
const AUDIO = "audio";
const ADDRESS = "address";
const DETAILS = "details";
const SUMMARY = "summary";
const BLOCKQUOTE = "blockquote";
const KBD = "kbd";
const SAMP = "samp";
const B = "b";
const STRONG = "strong";
const EM = "em";
const I = "i";
const U = "u";
const INS = "ins";
const DEL = "del";
const S = "s";
const SUP = "sup";
const SUB = "sub";
const SMALL = "small";
const ABBR = "abbr";
const Q = "q";
const CITE = "cite";
const DFN = "dfn";
const VAR = "var";
const MARK = "mark";
const TIME = "time";
const UL = "ul";
const LI = "li";

// http://zuga.net/articles/html-heading-elements
const H1Style = TextStyle(fontSize: 32);
const H2Style = TextStyle(fontSize: 24);
const H3Style = TextStyle(fontSize: 18.72);
const H4Style = TextStyle(fontSize: 16);
const H5Style = TextStyle(fontSize: 13.28);
const H6Style = TextStyle(fontSize: 10.72);
const AStyle = TextStyle(color: Colors.blue);
final CodeStyle = GoogleFonts.jetBrainsMono();
const Italic = TextStyle(fontStyle: FontStyle.italic);
const Bold = TextStyle(fontWeight: FontWeight.bold);
const Underlined = TextStyle(decoration: TextDecoration.underline);
const DottedUnderline = TextStyle(
  decoration: TextDecoration.underline,
  decorationStyle: TextDecorationStyle.dotted,
);
const Strikethrough = TextStyle(decoration: TextDecoration.lineThrough);
const Superscript = TextStyle(fontFeatures: [FontFeature.superscripts()]);
const Subscript = TextStyle(fontFeatures: [FontFeature.subscripts()]);
const Small = TextStyle(fontSize: 9);
const Highlighted = TextStyle(backgroundColor: Colors.yellow);

const ComponentRenderError = "Cannot render the component";
