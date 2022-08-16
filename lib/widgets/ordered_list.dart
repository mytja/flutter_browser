import 'package:flutter/material.dart';
import 'package:flutter_browser/widgets/mapper.dart';

class GuineaOrderedList extends StatelessWidget {
  const GuineaOrderedList(
      {Key? key,
      required this.widgets,
      required this.url,
      required this.callback,
      required this.css})
      : super(key: key);

  final Future<void> Function(String type, Map data) callback;

  final List widgets;
  final String url;
  final List css;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.fromLTRB(16, 30, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widgets.map((w) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${widgets.indexOf(w) + 1}.",
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.55,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              FutureBuilder(
                future: mapToWidgets(
                  context,
                  w,
                  url,
                  callback,
                  css,
                ),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) return const SizedBox();
                  return Column(
                    children: snapshot.data,
                  );
                },
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
