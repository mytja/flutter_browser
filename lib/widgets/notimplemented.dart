import 'package:flutter/material.dart';

class GuineaNotImplementedWidget extends StatelessWidget {
  const GuineaNotImplementedWidget(
      {Key? key, this.body = "This doesn't seem to be implemented yet..."})
      : super(key: key);

  final String body;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text(
            "(^-^*)",
            style: TextStyle(fontSize: 150),
          ),
          Text(
            body,
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
