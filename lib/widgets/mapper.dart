// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_browser/constants/settings.dart';
import 'package:flutter_browser/widgets/details.dart';
import 'package:flutter_browser/widgets/htmldefinitions.dart';
import 'package:flutter_browser/widgets/iframe.dart';
import 'package:flutter_browser/widgets/notimplemented.dart';
import 'package:flutter_browser/widgets/ordered_list.dart';
import 'package:flutter_browser/widgets/player.dart';
import 'package:flutter_browser/widgets/progress.dart';
import 'package:flutter_browser/widgets/select.dart';
import 'package:flutter_browser/widgets/table.dart';
import 'package:flutter_browser/widgets/input.dart';
import 'package:flutter_browser/widgets/unordered_list.dart';
import 'package:flutter_browser/widgets/videoplayer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guinea_html/guinea_html.dart';

Future<List<Widget>> mapToWidgets(
  BuildContext context,
  Map html,
  String url,
  Future<void> Function(String type, Map data) callback,
  List css, {
  String? link,
  List<Widget>? row,
  TextStyle? textStyle,
  int iFrameDepth = 1,
  bool useGestureDetector = false,
}) async {
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
                children: await mapToWidgets(
                  context,
                  widget,
                  url,
                  callback,
                  css,
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
                children: await mapToWidgets(
                  context,
                  widget,
                  url,
                  callback,
                  css,
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
                children: await mapToWidgets(
                  context,
                  widget,
                  url,
                  callback,
                  css,
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
                children: await mapToWidgets(
                  context,
                  widget,
                  url,
                  callback,
                  css,
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
                children: await mapToWidgets(
                  context,
                  widget,
                  url,
                  callback,
                  css,
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
                children: await mapToWidgets(
                  context,
                  widget,
                  url,
                  callback,
                  css,
                  textStyle: H6Style,
                ),
              ),
            ],
          ),
        );
        continue;
      case TEXT:
        debugPrint("Rendering text $widget with style $textStyle");
        Widget w;
        if (useGestureDetector) {
          w = GestureDetector(
            onTap: () async {
              if (link == null) {
                return;
              }
              await callback("newURL", {"url": link});
            },
            child: Text(
              widget["text"] ?? ComponentRenderError,
              style: textStyle,
            ),
          );
        } else {
          w = Text(
            widget["text"] ?? ComponentRenderError,
            style: textStyle,
          );
        }
        row!.add(w);
        continue;
      case B:
        debugPrint("Rendering b $widget");
        row!.addAll(await mapToWidgets(
          context,
          widget,
          url,
          callback,
          css,
          textStyle: Bold,
        ));
        continue;
      case STRONG:
        debugPrint("Rendering strong $widget");
        row!.addAll(await mapToWidgets(
          context,
          widget,
          url,
          callback,
          css,
          textStyle: Bold,
        ));
        continue;
      case EM:
        debugPrint("Rendering em $widget");
        row!.addAll(await mapToWidgets(
          context,
          widget,
          url,
          callback,
          css,
          textStyle: Italic,
        ));
        continue;
      case I:
        debugPrint("Rendering i $widget");
        row!.addAll(await mapToWidgets(
          context,
          widget,
          url,
          callback,
          css,
          textStyle: Italic,
        ));
        continue;
      case DFN:
        debugPrint("Rendering dfn $widget");
        row!.addAll(await mapToWidgets(
          context,
          widget,
          url,
          callback,
          css,
          textStyle: Italic,
        ));
        continue;
      case CITE:
        debugPrint("Rendering cite $widget");
        row!.addAll(await mapToWidgets(
          context,
          widget,
          url,
          callback,
          css,
          textStyle: Italic,
        ));
        continue;
      case VAR:
        debugPrint("Rendering var $widget");
        row!.addAll(await mapToWidgets(
          context,
          widget,
          url,
          callback,
          css,
          textStyle: Italic,
        ));
        continue;
      case MARK:
        debugPrint("Rendering mark $widget");
        row!.addAll(await mapToWidgets(
          context,
          widget,
          url,
          callback,
          css,
          textStyle: Highlighted,
        ));
        continue;
      case U:
        debugPrint("Rendering u $widget");
        row!.addAll(await mapToWidgets(
          context,
          widget,
          url,
          callback,
          css,
          textStyle: Underlined,
        ));
        continue;
      case INS:
        debugPrint("Rendering ins $widget");
        row!.addAll(await mapToWidgets(
          context,
          widget,
          url,
          callback,
          css,
          textStyle: Underlined,
        ));
        continue;
      case DEL:
        debugPrint("Rendering del $widget");
        row!.addAll(await mapToWidgets(
          context,
          widget,
          url,
          callback,
          css,
          textStyle: Strikethrough,
        ));
        continue;
      case S:
        debugPrint("Rendering s $widget");
        row!.addAll(await mapToWidgets(
          context,
          widget,
          url,
          callback,
          css,
          textStyle: Strikethrough,
        ));
        continue;
      case SUP:
        debugPrint("Rendering sup $widget");
        row!.addAll(await mapToWidgets(
          context,
          widget,
          url,
          callback,
          css,
          textStyle: Superscript,
        ));
        continue;
      case SUB:
        debugPrint("Rendering sub $widget");
        row!.addAll(await mapToWidgets(
          context,
          widget,
          url,
          callback,
          css,
          textStyle: Subscript,
        ));
        continue;
      case SMALL:
        debugPrint("Rendering small $widget");
        row!.addAll(await mapToWidgets(
          context,
          widget,
          url,
          callback,
          css,
          textStyle: Small,
        ));
        continue;
      case ABBR:
        debugPrint("Rendering abbr $widget");
        row!.addAll(await mapToWidgets(
          context,
          widget,
          url,
          callback,
          css,
          textStyle: DottedUnderline,
        ));
        continue;
      case Q:
        debugPrint("Rendering q $widget");
        row!.add(const Text('"'));
        row.addAll(await mapToWidgets(
          context,
          widget,
          url,
          callback,
          css,
        ));
        row.add(const Text('"'));
        continue;
      case TIME:
        debugPrint("Rendering time $widget");
        row!.addAll(await mapToWidgets(
          context,
          widget,
          url,
          callback,
          css,
        ));
        continue;
      case KBD:
        debugPrint("Rendering kbd $widget");
        row!.addAll(
          await mapToWidgets(
            context,
            widget,
            url,
            callback,
            css,
            textStyle: CodeStyle,
          ),
        );
        continue;
      case SAMP:
        debugPrint("Rendering samp $widget");
        row!.addAll(
          await mapToWidgets(
            context,
            widget,
            url,
            callback,
            css,
            textStyle: CodeStyle,
          ),
        );
        continue;
      case CODE:
        debugPrint("Rendering code $widget");
        row!.addAll(
          await mapToWidgets(
            context,
            widget,
            url,
            callback,
            css,
            textStyle: CodeStyle,
          ),
        );
        continue;
      case PRE:
        debugPrint("Rendering pre $widget");
        row!.addAll(
          await mapToWidgets(
            context,
            widget,
            url,
            callback,
            css,
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
            children: await mapToWidgets(
              context,
              widget,
              url,
              callback,
              css,
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
          await mapToWidgets(
            context,
            widget,
            url,
            callback,
            css,
            textStyle: Italic,
          ),
        );
        continue;
      case A:
        debugPrint("Rendering a $widget");
        row!.addAll(
          await mapToWidgets(
            context,
            widget,
            url,
            callback,
            css,
            textStyle: AStyle,
            link: widget["href"],
            useGestureDetector: true,
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
      case VIDEO:
        debugPrint("Rendering video $widget");
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
        if (url == null) {
          continue;
        }
        bool showControls = widget["attributes"]["controls"] != null;
        String? widthString = widget["attributes"]["width"];
        String? heightString = widget["attributes"]["height"];

        int height = 360;
        int width = 640;
        if (widthString != null) {
          width = int.parse(widthString);
        }
        if (heightString != null) {
          height = int.parse(heightString);
        }

        debugPrint(
            "Found source for audio widget $url with controls $showControls");
        row!.add(GuineaVideoPlayer(
          url: url,
          controls: showControls,
          height: height,
          width: width,
        ));
        continue;
      case IMG:
        debugPrint(
            "Rendering img $widget using URL ${widget["attributes"]["src"]}");
        if (widget["attributes"]["src"].toString().contains("base64,")) {
          row!.add(
            Image.memory(
              base64Decode(
                  widget["attributes"]["src"].toString().split("base64,")[1]),
              semanticLabel: widget["attributes"]["alt"] ??
                  "No image description provided",
              errorBuilder: ((context, error, stackTrace) {
                debugPrint(
                    "Failed to load an image using base64 encoding with error $error and stackTrace $stackTrace.");
                return const SizedBox(child: Icon(Icons.image));
              }),
            ),
          );
        } else {
          String imgUrl = getCorrectURL(widget["attributes"]["src"] ?? "", url);
          if (imgUrl.endsWith(".svg")) {
            row!.add(
              SvgPicture.network(
                imgUrl,
              ),
            );
            continue;
          }
          row!.add(
            Image.network(
              imgUrl,
              semanticLabel: widget["attributes"]["alt"] ??
                  "No image description provided",
              errorBuilder: ((context, error, stackTrace) {
                debugPrint(
                    "Failed to make a request to $imgUrl for image loading through network with error $error and stackTrace $stackTrace.");
                return const SizedBox(child: Icon(Icons.image));
              }),
            ),
          );
        }
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

        insiderRow = await mapToWidgets(
          context,
          widget,
          url,
          callback,
          css,
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
      case HR:
        widgets.add(Row(
          children: row!,
        ));
        row = [];
        widgets.add(
          const Divider(
            height: 20,
            //thickness: 5,
            //indent: 20,
            //endIndent: 0,
            color: Colors.black,
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
              summary.addAll(await mapToWidgets(
                context,
                i,
                url,
                callback,
                css,
                textStyle: H3Style,
              ));
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
          GuineaDetails(
            body: body,
            summary: summary,
            url: url,
            callback: callback,
            css: css,
          ),
        );
        continue;
      case IFRAME:
        if (!kEnableEmbeds) {
          row!.add(const GuineaNotImplementedWidget(
              body: "iFrames are disabled due to perfomance reasons."));
          continue;
        }
        debugPrint("Rendering iframe $widget");
        row!.add(
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black54, width: 2),
            ),
            child: GuineaIFrame(
              url: widget["attributes"]["src"] ?? "",
              parentUrl: url,
              iFrameDepth: iFrameDepth,
              callback: callback,
            ),
          ),
        );
        continue;
      case EMBED:
        if (!kEnableEmbeds) {
          row!.add(const GuineaNotImplementedWidget(
              body: "Embeds are disabled due to perfomance reasons."));
          continue;
        }
        debugPrint("Rendering embed $widget");
        row!.add(GuineaIFrame(
          url: widget["attributes"]["src"] ?? "",
          parentUrl: url,
          iFrameDepth: iFrameDepth,
          callback: callback,
        ));
        continue;
      case OBJECT:
        if (!kEnableEmbeds) {
          row!.add(const GuineaNotImplementedWidget(
              body: "Objects are disabled due to perfomance reasons."));
          continue;
        }
        debugPrint("Rendering object $widget");
        row!.add(GuineaIFrame(
          url: widget["attributes"]["data"] ?? "",
          parentUrl: url,
          iFrameDepth: iFrameDepth,
          callback: callback,
        ));
        continue;
      case CANVAS:
        row!.add(const GuineaNotImplementedWidget());
        continue;
      case PROGRESS:
        row!.add(const GuineaProgress());
        continue;
      case SVG:
        row!.add(SvgPicture.string(widget["text"]));
        continue;
      case TABLE:
        var parsedTable = await parseHTMLTable(
          context,
          url,
          widget["elements"],
          callback,
          css,
        );
        debugPrint("Rendering table $widget using $parsedTable");
        row!.add(GuineaTable(
          data: parsedTable,
        ));
        continue;

      // Form widgets
      case INPUT:
        debugPrint("Rendering input $widget");
        row!.add(
          GuineaTextField(
            callback: callback,
            type: widget["attributes"]["type"] ?? "text",
            id: widget["id"] ?? "",
            label: widget["attributes"] != null &&
                    widget["attributes"]["placeholder"] != null
                ? widget["attributes"]["placeholder"]
                : widget["elements"].length != 0
                    ? widget["elements"][0]["text"]
                    : "",
            isChecked: widget["attributes"] != null &&
                widget["attributes"]["checked"] != null,
            text: widget["attributes"] != null &&
                    widget["attributes"]["value"] != null
                ? widget["attributes"]["value"]
                : "",
            disabled: widget["attributes"] != null &&
                widget["attributes"]["disabled"] != null,
          ),
        );
        continue;
      case BUTTON:
        debugPrint("Rendering input $widget");
        row!.add(
          GuineaTextField(
            callback: callback,
            type: widget["attributes"] != null &&
                    widget["attributes"]["type"] != null
                ? widget["attributes"]["type"]
                : "text",
            id: widget["id"] ?? "",
            text: widget["text"] != null
                ? widget["text"]
                    .toString()
                    .replaceAll("&lt;", "<") // Junky solution
                    .replaceAll("&gt;", ">")
                : "",
            disabled: widget["attributes"] != null &&
                widget["attributes"]["disabled"] != null,
          ),
        );
        continue;
      case TEXTAREA:
        debugPrint("Rendering input $widget");
        int? lineCount = int.tryParse(
          widget["attributes"] != null && widget["attributes"]["rows"] != null
              ? widget["attributes"]["rows"]
              : "2",
        );
        int? width = int.tryParse(
          widget["attributes"] != null && widget["attributes"]["cols"] != null
              ? widget["attributes"]["cols"]
              : "40",
        );
        row!.add(
          GuineaTextField(
              callback: callback,
              type: "textarea",
              id: widget["id"] ?? "",
              lines: lineCount ?? 1,
              width: (width ?? 40) * 8,
              label: widget["attributes"] != null &&
                      widget["attributes"]["placeholder"] != null
                  ? widget["attributes"]["placeholder"]
                  : ""),
        );
        continue;
      case SELECT:
        List<String> options = extractOptions(widget);
        row!.add(
          GuineaSelect(
            options: options,
          ),
        );
        continue;

      // List widgets
      case LI:
        debugPrint("Rendering li $widget");

        List<Widget> column = [];

        column.addAll(await mapToWidgets(
          context,
          widget,
          url,
          callback,
          css,
        ));
        row!.add(Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: column,
        ));

        continue;
      case UL:
        debugPrint("Rendering ul $widget");
        // widgets.add(
        //   Row(
        //     children: row!,
        //   ),
        // );

        row!.add(
          const SizedBox(
            width: 20,
          ),
        );

        List elements = widget["elements"];

        row.add(GuineaUnorderedList(
          widgets: elements,
          url: url,
          callback: callback,
          css: css,
        ));

        widgets.add(
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: row,
          ),
        );
        row = [];

        continue;
      case OL:
        debugPrint("Rendering ol $widget");
        // widgets.add(
        //   Row(
        //     children: row!,
        //   ),
        // );

        row!.add(
          const SizedBox(
            width: 20,
          ),
        );

        List elements = widget["elements"];

        row.add(GuineaOrderedList(
          widgets: elements,
          url: url,
          callback: callback,
          css: css,
        ));

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
        widgets.addAll(await mapToWidgets(
          context,
          widget,
          url,
          callback,
          css,
        ));
        continue;
      case SCRIPT:
        continue;
      case STYLE:
        css = parseCSS(widget["text"]);
        continue;
      case LINK:
        if (widget["attributes"]["rel"] == "stylesheet") {
          String cssUrl = getCorrectURL(widget["href"], url);
          debugPrint("Hitting CSS using $cssUrl");
          var get = await dio.get(cssUrl);
          css.addAll(parseCSS(get.data.toString()));
          debugPrint("Current CSS $css");
        }
        continue;
      case NOSCRIPT:
        debugPrint("Rendering noscript $widget");
        widgets.addAll(await mapToWidgets(
          context,
          widget,
          url,
          callback,
          css,
        ));
        continue;
      case SPAN:
        debugPrint("Rendering span $widget");
        widgets.addAll(await mapToWidgets(
          context,
          widget,
          url,
          callback,
          css,
        ));
        continue;
      case HEAD:
        debugPrint("Rendering head $widget");
        widgets.addAll(await mapToWidgets(
          context,
          widget,
          url,
          callback,
          css,
        ));
        continue;
      case BODY:
        debugPrint("Rendering body $widget");
        widgets.addAll(await mapToWidgets(
          context,
          widget,
          url,
          callback,
          css,
        ));
        continue;
      case DIV:
        debugPrint("Rendering div $widget");
        widgets.addAll(await mapToWidgets(
          context,
          widget,
          url,
          callback,
          css,
        ));
        continue;
      case HEADER:
        debugPrint("Rendering header $widget");
        widgets.addAll(await mapToWidgets(
          context,
          widget,
          url,
          callback,
          css,
        ));
        continue;
      case FOOTER:
        debugPrint("Rendering footer $widget");
        widgets.addAll(await mapToWidgets(
          context,
          widget,
          url,
          callback,
          css,
        ));
        continue;
      case ARTICLE:
        debugPrint("Rendering article $widget");
        widgets.addAll(await mapToWidgets(
          context,
          widget,
          url,
          callback,
          css,
        ));
        continue;
      case MAIN:
        debugPrint("Rendering main $widget");
        widgets.addAll(await mapToWidgets(
          context,
          widget,
          url,
          callback,
          css,
        ));
        continue;
      case SECTION:
        debugPrint("Rendering section $widget");
        widgets.addAll(await mapToWidgets(
          context,
          widget,
          url,
          callback,
          css,
        ));
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
          widgets.addAll(await mapToWidgets(
            context,
            widget,
            url,
            callback,
            css,
          ));
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
