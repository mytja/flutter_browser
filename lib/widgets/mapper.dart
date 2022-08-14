// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_browser/widgets/details.dart';
import 'package:flutter_browser/widgets/htmldefinitions.dart';
import 'package:flutter_browser/widgets/player.dart';
import 'package:flutter_browser/widgets/unordered_list.dart';

List<Widget> mapToWidgets(BuildContext context, Map html,
    {List<Widget>? row, TextStyle? textStyle}) {
  List<Widget> widgets = [];
  List body = html["elements"];
  row ??= [];

  double c_width = MediaQuery.of(context).size.width * 0.9;

  for (Map widget in body) {
    switch (widget["name"].toString().toLowerCase()) {
      // Text widgets
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
        debugPrint("Rendering text $widget with style $textStyle");
        row!.add(
          Text(
            widget["text"] ?? ComponentRenderError,
            style: textStyle,
          ),
        );
        continue;
      case B:
        debugPrint("Rendering b $widget");
        row!.addAll(mapToWidgets(context, widget, textStyle: Bold));
        continue;
      case STRONG:
        debugPrint("Rendering strong $widget");
        row!.addAll(mapToWidgets(context, widget, textStyle: Bold));
        continue;
      case EM:
        debugPrint("Rendering em $widget");
        row!.addAll(mapToWidgets(context, widget, textStyle: Italic));
        continue;
      case I:
        debugPrint("Rendering i $widget");
        row!.addAll(mapToWidgets(context, widget, textStyle: Italic));
        continue;
      case DFN:
        debugPrint("Rendering dfn $widget");
        row!.addAll(mapToWidgets(context, widget, textStyle: Italic));
        continue;
      case CITE:
        debugPrint("Rendering cite $widget");
        row!.addAll(mapToWidgets(context, widget, textStyle: Italic));
        continue;
      case VAR:
        debugPrint("Rendering var $widget");
        row!.addAll(mapToWidgets(context, widget, textStyle: Italic));
        continue;
      case MARK:
        debugPrint("Rendering mark $widget");
        row!.addAll(mapToWidgets(context, widget, textStyle: Highlighted));
        continue;
      case U:
        debugPrint("Rendering u $widget");
        row!.addAll(mapToWidgets(context, widget, textStyle: Underlined));
        continue;
      case INS:
        debugPrint("Rendering ins $widget");
        row!.addAll(mapToWidgets(context, widget, textStyle: Underlined));
        continue;
      case DEL:
        debugPrint("Rendering del $widget");
        row!.addAll(mapToWidgets(context, widget, textStyle: Strikethrough));
        continue;
      case S:
        debugPrint("Rendering s $widget");
        row!.addAll(mapToWidgets(context, widget, textStyle: Strikethrough));
        continue;
      case SUP:
        debugPrint("Rendering sup $widget");
        row!.addAll(mapToWidgets(context, widget, textStyle: Superscript));
        continue;
      case SUB:
        debugPrint("Rendering sub $widget");
        row!.addAll(mapToWidgets(context, widget, textStyle: Subscript));
        continue;
      case SMALL:
        debugPrint("Rendering small $widget");
        row!.addAll(mapToWidgets(context, widget, textStyle: Small));
        continue;
      case ABBR:
        debugPrint("Rendering abbr $widget");
        row!.addAll(mapToWidgets(context, widget, textStyle: DottedUnderline));
        continue;
      case Q:
        debugPrint("Rendering abbr $widget");
        row!.add(const Text('"'));
        row.addAll(mapToWidgets(context, widget));
        row.add(const Text('"'));
        continue;
      case TIME:
        debugPrint("Rendering time $widget");
        row!.addAll(mapToWidgets(context, widget));
        continue;
      case KBD:
        debugPrint("Rendering kbd $widget");
        row!.addAll(
          mapToWidgets(
            context,
            widget,
            textStyle: CodeStyle,
          ),
        );
        continue;
      case SAMP:
        debugPrint("Rendering samp $widget");
        row!.addAll(
          mapToWidgets(
            context,
            widget,
            textStyle: CodeStyle,
          ),
        );
        continue;
      case CODE:
        debugPrint("Rendering code $widget");
        row!.addAll(
          mapToWidgets(
            context,
            widget,
            textStyle: CodeStyle,
          ),
        );
        continue;
      case PRE:
        debugPrint("Rendering pre $widget");
        row!.addAll(
          mapToWidgets(
            context,
            widget,
            textStyle: CodeStyle,
          ),
        );
        continue;
      case BLOCKQUOTE:
        debugPrint("Rendering blockquote $widget");
        widgets.add(
          Row(
            children: row!,
          ),
        );
        row = [
          const SizedBox(
            width: 50,
          ),
        ];
        row.add(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: mapToWidgets(
              context,
              widget,
            ),
          ),
        );
        widgets.add(
          Row(
            children: row,
          ),
        );
        row = [];
        continue;
      case ADDRESS:
        debugPrint("Rendering address $widget");
        row!.addAll(
          mapToWidgets(
            context,
            widget,
            textStyle: Italic,
          ),
        );
        continue;

      // Multimedia widgets
      case AUDIO:
        debugPrint("Rendering audio $widget");
        List audioBody = widget["elements"];
        String? url;
        if (audioBody.isNotEmpty) {
          for (var i in audioBody) {
            debugPrint("Trying to find source on $i");
            if (i["name"].toString().toLowerCase() == "source") {
              url = i["attributes"]["src"];
              break;
            }
          }
        }
        debugPrint("Found source for audio widget $url");
        row!.add(GuineaAudio(url: url));
        continue;
      case IMG:
        debugPrint("Rendering img $widget");
        row!.add(
          Image.network(
            widget["attributes"]["src"] ?? "",
            semanticLabel:
                widget["attributes"]["alt"] ?? "No image description provided",
          ),
        );
        continue;

      // Line break widgets
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

      // Interactive widgets (Material widgets - not native HTML)
      case DETAILS:
        debugPrint("Rendering details $widget");
        List detailsBody = widget["elements"];
        List<Widget> summary = [];
        if (detailsBody.isNotEmpty) {
          for (var i in detailsBody) {
            debugPrint("Trying to find summary on $i");
            if (i["name"].toString().toLowerCase() == SUMMARY) {
              summary.addAll(mapToWidgets(context, i, textStyle: H3Style));
              detailsBody.remove(i);
              break;
            }
          }
        }
        Map body = {
          "elements": detailsBody,
        };
        debugPrint("Found summary $summary");
        widgets.add(
          Row(
            children: row!,
          ),
        );
        row = [];
        widgets.add(
          GuineaDetails(body: body, summary: summary),
        );
        continue;
      case A:
        debugPrint("Rendering a $widget");
        row!.addAll(
          mapToWidgets(
            context,
            widget,
            textStyle: AStyle,
          ),
        );
        continue;

      case LI:
        debugPrint("Rendering li $widget");

        List<Widget> column = [];

        column.addAll(mapToWidgets(context, widget));
        row!.add(Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: column,
        ));

        continue;

      // List widgets
      case UL:
        debugPrint("Rendering ul $widget");
        // widgets.add(
        //   Row(
        //     children: row!,
        //   ),
        // );

        row = [
          const SizedBox(
            width: 50,
          ),
        ];

        List elements = widget["elements"];

        row.add(GuineaUnorderedList(elements));

        debugPrint("tttttt $row");

        widgets.add(
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: row,
          ),
        );
        row = [];

        continue;

      // Informative widgets (nothing to render)
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
    Row(
      children: row!,
    ),
  );
  row = [];
  return widgets;
}
