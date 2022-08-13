import 'package:flutter/material.dart';

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

// http://zuga.net/articles/html-heading-elements
const H1Style = TextStyle(fontSize: 32);
const H2Style = TextStyle(fontSize: 24);
const H3Style = TextStyle(fontSize: 18.72);
const H4Style = TextStyle(fontSize: 16);
const H5Style = TextStyle(fontSize: 13.28);
const H6Style = TextStyle(fontSize: 10.72);
const AStyle = TextStyle(color: Colors.blue);

const ComponentRenderError = "Cannot render the component";

List<Widget> mapToWidgets(BuildContext context, Map html,
    {List<Widget>? row, TextStyle? textStyle}) {
  List<Widget> widgets = [];
  List body = html["elements"];
  row ??= [];

  double c_width = MediaQuery.of(context).size.width * 0.9;

  for (Map widget in body) {
    switch (widget["name"].toString().toLowerCase()) {
      case H1:
        widgets.add(
          Row(
            children: row!,
          ),
        );
        row = [];
        widgets.add(
          Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              Row(
                children: mapToWidgets(
                  context,
                  widget,
                  textStyle: H1Style,
                ),
              ),
            ],
          ),
        );
        continue;
      case H2:
        widgets.add(
          Row(
            children: row!,
          ),
        );
        row = [];
        widgets.add(
          Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              Row(
                children: mapToWidgets(
                  context,
                  widget,
                  textStyle: H2Style,
                ),
              ),
            ],
          ),
        );
        continue;
      case H3:
        widgets.add(
          Row(
            children: row!,
          ),
        );
        row = [];
        widgets.add(
          Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              Row(
                children: mapToWidgets(
                  context,
                  widget,
                  textStyle: H3Style,
                ),
              ),
            ],
          ),
        );
        continue;
      case H4:
        widgets.add(
          Row(
            children: row!,
          ),
        );
        row = [];
        widgets.add(
          Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              Row(
                children: mapToWidgets(
                  context,
                  widget,
                  textStyle: H4Style,
                ),
              ),
            ],
          ),
        );
        continue;
      case H5:
        widgets.add(
          Row(
            children: row!,
          ),
        );
        row = [];
        widgets.add(
          Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              Row(
                children: mapToWidgets(
                  context,
                  widget,
                  textStyle: H5Style,
                ),
              ),
            ],
          ),
        );
        continue;
      case H6:
        widgets.add(
          Row(
            children: row!,
          ),
        );
        row = [];
        widgets.add(
          Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              Row(
                children: mapToWidgets(
                  context,
                  widget,
                  textStyle: H6Style,
                ),
              ),
            ],
          ),
        );
        continue;
      case TEXT:
        row!.add(
          Text(
            widget["text"] ?? ComponentRenderError,
            style: textStyle,
          ),
        );
        continue;
      case BR:
        widgets.add(
          Row(
            children: row!,
          ),
        );
        row = [];
        continue;
      case P:
        widgets.add(
          Row(
            children: row!,
          ),
        );
        row = [];
        List<Widget> insiderRow = [];

        insiderRow = mapToWidgets(
          context,
          widget,
        );

        widgets.add(
          Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              Row(
                children: insiderRow,
              ),
            ],
          ),
        );
        continue;
      case A:
        row!.addAll(
          mapToWidgets(
            context,
            widget,
            textStyle: AStyle,
          ),
        );
        continue;
      case IMG:
        debugPrint("Rendering html $widget");
        row!.add(
          Image.network(
            widget["attributes"]["src"],
          ),
        );
        continue;
      case CODE:
        debugPrint("Rendering html $widget");
        row!.addAll(
          mapToWidgets(
            context,
            widget,
            textStyle: TextStyle(fontFamily: "JetBrainsMono"),
          ),
        );
        continue;
      case HTML:
        debugPrint("Rendering html $widget");
        widgets.addAll(mapToWidgets(context, widget));
        continue;
      case HEAD:
        debugPrint("Rendering head $widget");
        widgets.addAll(mapToWidgets(context, widget));
        continue;
      case BODY:
        debugPrint("Rendering body $widget");
        widgets.addAll(mapToWidgets(context, widget));
        continue;
      case DIV:
        debugPrint("Rendering div $widget");
        widgets.addAll(mapToWidgets(context, widget));
        continue;
      case HEADER:
        debugPrint("Rendering header $widget");
        widgets.addAll(mapToWidgets(context, widget));
        continue;
      case FOOTER:
        debugPrint("Rendering footer $widget");
        widgets.addAll(mapToWidgets(context, widget));
        continue;
      case ARTICLE:
        debugPrint("Rendering article $widget");
        widgets.addAll(mapToWidgets(context, widget));
        continue;
      case MAIN:
        debugPrint("Rendering main $widget");
        widgets.addAll(mapToWidgets(context, widget));
        continue;
      case SECTION:
        debugPrint("Rendering section $widget");
        widgets.addAll(mapToWidgets(context, widget));
        continue;
      case META:
        // Meta tags shouldn't be rendered
        continue;
      case TITLE:
        // Title tags are just some kind of form of a meta tag, so they don't shouldn't be rendered
        continue;
      default:
        if (widget["elements"] != null && widget["elements"].length != 0) {
          // Unknown components
          // In this case, system will try to guess how to implement the component
          debugPrint("Rendering unknown component $widget");
          widgets.addAll(mapToWidgets(context, widget));
          continue;
        }
    }
  }
  widgets.add(
    Row(children: row!),
  );
  row = [];
  return widgets;
}
