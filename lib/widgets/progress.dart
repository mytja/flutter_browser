import 'package:flutter/material.dart';

class GuineaProgress extends StatefulWidget {
  const GuineaProgress({Key? key}) : super(key: key);

  @override
  State<GuineaProgress> createState() => _GuineaProgressState();
}

/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _GuineaProgressState extends State<GuineaProgress>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: LinearProgressIndicator(
        value: controller.value,
      ),
    );
  }
}
