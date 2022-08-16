import 'package:flutter/material.dart';
import 'package:flutter_browser/widgets/htmldefinitions.dart';

List<String> extractOptions(Map widget, {List<String>? textWidgets}) {
  textWidgets ??= [];
  var elements = widget["elements"];
  if (elements == null) {
    return textWidgets;
  }
  for (var i in elements) {
    switch (i["name"].toString().toLowerCase()) {
      case TEXT:
        textWidgets!.add(i["text"]);
        continue;
      default:
        textWidgets = extractOptions(
          i,
          textWidgets: textWidgets,
        );
    }
  }
  return textWidgets!;
}

class GuineaSelect extends StatefulWidget {
  const GuineaSelect({Key? key, required this.options}) : super(key: key);

  final List<String> options;

  @override
  State<GuineaSelect> createState() => _GuineaSelectState();
}

class _GuineaSelectState extends State<GuineaSelect> {
  String dropdownValue = '';

  @override
  Widget build(BuildContext context) {
    debugPrint(widget.options.toString());

    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items:
          ["", ...widget.options].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
