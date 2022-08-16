import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_browser/widgets/slider.dart';

String checked = "";

class GuineaTextField extends StatefulWidget {
  const GuineaTextField({
    Key? key,
    required this.id,
    required this.callback,
    this.isChecked = false,
    this.label = "",
    this.type = "",
    this.text = "",
    this.lines = 1,
    this.width = 400,
    this.disabled = false,
  }) : super(key: key);

  final String label;
  final String type;
  final String id;
  final bool isChecked;
  final int lines;
  final int width;
  final String text;
  final bool disabled;

  final Future<void> Function(String type, Map data) callback;

  @override
  State<GuineaTextField> createState() => _GuineaTextFieldState();
}

class _GuineaTextFieldState extends State<GuineaTextField> {
  late TextEditingController _controller;

  late bool isChecked;
  FilePickerResult? selectedFile;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    isChecked = widget.isChecked;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type == "checkbox") {
      return FormField(
        builder: (FormFieldState state) => Checkbox(
          checkColor: Colors.white,
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = !isChecked;
            });
          },
        ),
      );
    } else if (widget.type == "radio") {
      return FormField(
        builder: (FormFieldState state) => Radio(
          value: checked,
          groupValue: widget.id,
          onChanged: (String? value) {
            setState(() {
              checked = value!;
            });
          },
        ),
      );
    } else if (widget.type == "submit" ||
        widget.type == "button" ||
        widget.type == "reset") {
      return TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              widget.disabled ? Colors.grey : Colors.blue),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        ),
        onPressed: () async {
          if (widget.disabled) {
            return;
          }
          if (widget.type == "reset") {
            await widget.callback("resetForm", {});
          }
        },
        child: Text(widget.text),
      );
    } else if (widget.type == "range") {
      return GuineaSlider(
        value: int.parse(widget.text),
      );
    } else if (widget.type == "file") {
      return Row(
        children: [
          TextButton(
            onPressed: () async {
              selectedFile = await FilePicker.platform.pickFiles();
              setState(() {});
            },
            child: const Text("Select a file"),
          ),
          if (selectedFile != null)
            for (var i in selectedFile!.files) Text(i.name),
        ],
      );
    }

    return SizedBox(
      width: widget.width.toDouble(),
      child: FormField(
        builder: (FormFieldState state) => TextField(
          maxLines: widget.lines,
          controller: _controller,
          obscureText: widget.type == "password",
          keyboardType: widget.type == "number" ? TextInputType.number : null,
          inputFormatters: <TextInputFormatter>[
            if (widget.type == "number") FilteringTextInputFormatter.digitsOnly,
          ],
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: widget.label,
          ),
        ),
      ),
    );
  }
}
