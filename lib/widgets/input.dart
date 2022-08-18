import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_browser/widgets/slider.dart';

String formUrl = "";
String formMethod = "";
String checked = "";
Map<String, TextEditingController> textEditingControllers = {};

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
    this.height,
    this.name = "",
    this.value = "",
    this.borderColor = "",
  }) : super(key: key);

  final String label;
  final String type;
  final String id;
  final bool isChecked;
  final int lines;
  final int width;
  final int? height;
  final String text;
  final bool disabled;
  final String name;
  final String value;
  final String borderColor;

  final Future<void> Function(String type, Map data) callback;

  @override
  State<GuineaTextField> createState() => _GuineaTextFieldState();
}

class _GuineaTextFieldState extends State<GuineaTextField> {
  late bool isChecked;
  FilePickerResult? selectedFile;

  @override
  void initState() {
    super.initState();
    if (widget.name != "") {
      textEditingControllers[widget.name] = TextEditingController();
      if (widget.value != "") {
        textEditingControllers[widget.name]?.text = widget.value;
      }
    }
    isChecked = widget.isChecked;
  }

  @override
  void dispose() {
    super.dispose();
    //textEditingControllers[widget.name]?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int? borderColor = int.tryParse(widget.borderColor);
    debugPrint("border $borderColor ${widget.type}");
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
      //print("test ${widget.height}");
      return SizedBox(
        height: widget.height?.toDouble(),
        child: TextButton(
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
            if (widget.type == "submit") {
              await widget.callback("submitForm", {
                "textFields": textEditingControllers,
                "url": formUrl,
                "method": formMethod,
              });
            }
          },
          child: Text(widget.text),
        ),
      );
    } else if (widget.type == "hidden") {
      return const SizedBox();
    } else if (widget.type == "range") {
      return GuineaSlider(
        value: int.parse(widget.text),
      );
    } else if (widget.type == "file") {
      return SizedBox(
        height: widget.height?.toDouble(),
        child: Row(
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
        ),
      );
    }

    return SizedBox(
      height: (widget.height ?? 20).toDouble() + 12,
      width: widget.width.toDouble(),
      child: FormField(
        builder: (FormFieldState state) => TextField(
          onChanged: ((value) {
            debugPrint("$textEditingControllers");
          }),
          maxLines: widget.lines,
          controller: textEditingControllers[widget.name],
          obscureText: widget.type == "password",
          keyboardType: widget.type == "number" ? TextInputType.number : null,
          inputFormatters: <TextInputFormatter>[
            if (widget.type == "number") FilteringTextInputFormatter.digitsOnly,
          ],
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(borderColor ?? 0xFF000000),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(borderColor ?? 0xFF000000),
              ),
            ),
            labelText: widget.label,
          ),
        ),
      ),
    );
  }
}
