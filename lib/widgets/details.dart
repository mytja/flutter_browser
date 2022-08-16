import 'package:flutter/material.dart';
import 'package:flutter_browser/widgets/mapper.dart';

class GuineaDetails extends StatefulWidget {
  const GuineaDetails({
    Key? key,
    required this.body,
    required this.summary,
    required this.url,
    required this.callback,
    required this.css,
  }) : super(key: key);

  final Future<void> Function(String type, Map data) callback;

  final Map body;
  final List<Widget> summary;
  final String url;
  final List css;

  @override
  State<GuineaDetails> createState() => _GuineaDetailsState();
}

class _GuineaDetailsState extends State<GuineaDetails> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: SizedBox(
        width: width,
        child: ExpansionPanelList(
          expansionCallback: ((panelIndex, isExpanded) {
            setState(() => isOpen = !isOpen);
          }),
          children: [
            ExpansionPanel(
              isExpanded: isOpen,
              canTapOnHeader: true,
              headerBuilder: (context, isOpen) {
                return Column(
                  children: widget.summary,
                );
              },
              body: FutureBuilder(
                future: mapToWidgets(
                  context,
                  widget.body,
                  widget.url,
                  widget.callback,
                  widget.css,
                ),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return Column(children: snapshot.data);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
