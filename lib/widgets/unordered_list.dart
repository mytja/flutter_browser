import 'package:flutter/material.dart';
import 'package:flutter_browser/widgets/css.dart';
import 'package:flutter_browser/widgets/mapper.dart';

class GuineaUnorderedList extends StatelessWidget {
  const GuineaUnorderedList({
    Key? key,
    required this.widgets,
    required this.url,
    required this.callback,
    required this.css,
  }) : super(key: key);

  final List widgets;
  final String url;
  final CSSOptions css;
  final Future<void> Function(String type, Map data) callback;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widgets.map((w) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '\u2022',
                style: TextStyle(
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
                  return Column(children: snapshot.data);
                },
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
