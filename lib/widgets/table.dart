import 'package:flutter/material.dart';
import 'package:flutter_browser/widgets/htmldefinitions.dart';
import 'package:flutter_browser/widgets/mapper.dart';

Future<Map<String, dynamic>> parseHTMLTable(
    BuildContext context,
    String url,
    List table,
    Future<void> Function(String type, Map data) callback,
    List css) async {
  Map<String, dynamic> m = {};
  List<List<Widget>> tableElements = [];
  List<Widget> head = [];
  List<Widget> footer = [];
  int max = 0;
  for (var i in table) {
    if (i["name"].toString().toLowerCase() == CAPTION) {
      m["caption"] = await mapToWidgets(
        context,
        i,
        url,
        callback,
        css,
      );
    } else if (i["name"].toString().toLowerCase() == THEAD) {
      for (var n in i["elements"]) {
        if (n["name"].toString().toLowerCase() == TR) {
          for (var x in n["elements"]) {
            head.add(
              Row(
                children: await mapToWidgets(
                  context,
                  x,
                  url,
                  callback,
                  css,
                  textStyle: Bold,
                ),
              ),
            );
          }
        }
      }
    } else if (i["name"].toString().toLowerCase() == TFOOT) {
      for (var n in i["elements"]) {
        if (n["name"].toString().toLowerCase() == TR) {
          for (var x in n["elements"]) {
            footer.add(
              Row(
                children: await mapToWidgets(
                  context,
                  x,
                  url,
                  callback,
                  css,
                  textStyle: Bold,
                ),
              ),
            );
          }
        }
      }
    } else if (i["name"].toString().toLowerCase() == TBODY) {
      int index = 0;
      tableElements = List.generate(i["elements"].length, (_) => []);
      for (var n in i["elements"]) {
        debugPrint("Current index in table rendering $index");
        if (n["name"].toString().toLowerCase() == TR) {
          if (max > n["elements"].length) {
            max = n["elements"].length;
          }
          for (var x in n["elements"]) {
            tableElements[index].add(
              Row(
                children: await mapToWidgets(
                  context,
                  x,
                  url,
                  callback,
                  css,
                ),
              ),
            );
          }
        }
        index++;
      }
    }
  }

  m["head"] = head;
  m["footer"] = footer;
  m["body"] = tableElements;

  for (int i = 0; i < m["body"].length; i++) {
    if (m["body"][i].length < max) {
      for (int n = 0; n < max - (m["body"][i].length); n++) {
        m["body"][i].add(const SizedBox());
      }
    }
  }

  return m;
}

class GuineaTable extends StatelessWidget {
  const GuineaTable({Key? key, required this.data}) : super(key: key);

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    print("tabler $data");
    return Column(
      children: [
        Center(child: Column(children: data["caption"] ?? [])),
        Table(
          //border: TableBorder.all(),
          defaultColumnWidth: const FixedColumnWidth(140),
          //defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: <TableRow>[
            if (data["head"] != null && data["head"].length != 0)
              TableRow(children: data["head"]),
            if (data["body"] != null)
              for (var row in data["body"]) TableRow(children: row),
            if (data["footer"] != null && data["footer"].length != 0)
              TableRow(children: data["footer"])
          ],
        ),
      ],
    );
  }
}
