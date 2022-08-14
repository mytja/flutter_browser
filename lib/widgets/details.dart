import 'package:flutter/material.dart';
import 'package:flutter_browser/widgets/mapper.dart';

class GuineaDetails extends StatefulWidget {
  const GuineaDetails({Key? key, required this.body, required this.summary})
      : super(key: key);

  final Map body;
  final List<Widget> summary;

  @override
  State<GuineaDetails> createState() => _GuineaDetailsState();
}

class _GuineaDetailsState extends State<GuineaDetails> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
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
              body: Column(
                children: mapToWidgets(context, widget.body),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
