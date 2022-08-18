import 'dart:core';

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
const ABBR = "abbr"; // ABBReviation
const Q = "q"; // Quote
const CITE = "cite"; // CITE
const DFN = "dfn"; // DeFiNition
const VAR = "var"; // VARiable definition
const MARK = "mark"; // MARK (note)
const TIME = "time"; // TIME
const UL = "ul"; // Unordered List
const LI = "li"; // List Item
const OL = "ol"; // Ordered List
const IFRAME = "iframe";
const VIDEO = "video";
const EMBED = "embed";
const INPUT = "input";
const SCRIPT = "script"; // Make sure to not render scripts
const STYLE = "style"; // Make sure to not render styles
const TABLE = "table";
const CAPTION = "caption";
const THEAD = "thead"; // Table HEAD
const TBODY = "tbody"; // Table BODY
const TFOOT = "tfoot"; // Table FOOT(er)
const TR = "tr"; // Table Row
const TD = "td"; // Table element (I guess...)
const HR = "hr"; // Horizontal Rule
const CANVAS = "canvas";
const PROGRESS = "progress";
const SVG = "svg";
const NOSCRIPT = "noscript";
const TEXTAREA = "textarea";
const BUTTON = "button";
const SELECT = "select";
const OPTGROUP = "optgroup";
const OPTION = "option";
const OBJECT = "object";
const SPAN = "span";
const LINK = "link";
const CENTER = "center";
const FORM = "form";

// http://zuga.net/articles/html-heading-elements
const H1Style = TextStyle(fontSize: 32);
const H2Style = TextStyle(fontSize: 24);
const H3Style = TextStyle(fontSize: 18.72);
const H4Style = TextStyle(fontSize: 16);
const H5Style = TextStyle(fontSize: 13.28);
const H6Style = TextStyle(fontSize: 10.72);

const Map<String, TextStyle> HeadingStyles = {
  H1: H1Style,
  H2: H2Style,
  H3: H3Style,
  H4: H4Style,
  H5: H5Style,
  H6: H6Style,
};

const AStyle = TextStyle(
  color: Colors.blue,
  decoration: TextDecoration.underline,
);
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

final Map<String, TextStyle> textStyles = {
  B: Bold,
  STRONG: Bold,
  EM: Italic,
  I: Italic,
  DFN: Italic,
  VAR: Italic,
  CITE: Italic,
  MARK: Highlighted,
  U: Underlined,
  INS: Underlined,
  DEL: Strikethrough,
  S: Strikethrough,
  SUP: Superscript,
  SUB: Subscript,
  SMALL: Small,
  ABBR: DottedUnderline,
  KBD: CodeStyle,
  SAMP: CodeStyle,
  CODE: CodeStyle,
  PRE: CodeStyle,
};

const ComponentRenderError = "Cannot render the component";
