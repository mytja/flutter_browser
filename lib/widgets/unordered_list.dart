import 'package:flutter/material.dart';
import 'package:flutter_browser/widgets/mapper.dart';

class GuineaBulletPoint extends StatelessWidget {
  const GuineaBulletPoint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
    );
  }
}

class GuineaUnorderedListElement extends StatelessWidget {
  const GuineaUnorderedListElement({Key? key, required this.widget})
      : super(key: key);

  final Map widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const GuineaBulletPoint(),
        ...mapToWidgets(context, widget),
      ],
    );
  }
}

class GuineaUnorderedList extends StatelessWidget {
  final List widgets;

  const GuineaUnorderedList(this.widgets);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(16, 15, 16, 16),
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
              ...mapToWidgets(context, w),
            ],
          );
        }).toList(),
      ),
    );
  }
}
