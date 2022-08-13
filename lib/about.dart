import 'package:flutter/material.dart';
import 'package:guinea_html/guinea_html.dart' as guinea_html;

const FlutterBrowserVersion = "Alpha 0.0.1";

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("About FlutterBrowser"),
      ),
      body: Center(
        child: ListView(
          children: [
            const Text(
              "FlutterBrowser",
              style: TextStyle(fontSize: 24),
            ),
            const Text(
              "also known as GuineaBrowser",
              style: TextStyle(fontSize: 18),
            ),
            const Text(
              "FlutterBrowser is based on the Guinea Web Framework (GWF).",
            ),
            const Text(
              "Why Guinea Web Framework, you might ask. I personally just like Guinea pigs. They are very cute.",
            ),
            const Text(
              "Guinea Web Framework is written from scratch to contain optimal performance and to prove, that Flutter is capable of rendering HTML.",
            ),
            const Text(
              "Guinea Web Framework is written in Go and compiled using CGo. FFI is used to access the Go's methods",
            ),
            const Text(
              "FlutterBrowser is only a frontend for displaying widgets. All of the processing and parsing of HTML is done within the Guinea Web Framework",
            ),
            const Text(
              "FlutterBrowser version: $FlutterBrowserVersion",
            ),
            Text(
              "GuineaHTML version: ${guinea_html.getVersion()}",
            ),
          ],
        ),
      ),
    );
  }
}
