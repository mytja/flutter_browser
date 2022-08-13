import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_browser/about.dart';
import 'package:flutter_browser/widgets/mapper.dart';
import 'package:guinea_html/guinea_html.dart' as guinea_html;
import 'package:selectable/selectable.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  guinea_html.initializeLibrary();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterBrowser',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'FlutterBrowser'),
    );
  }
}

Future<List<Widget>> fetchAndRenderSite(
    BuildContext context, String url) async {
  var response = await Dio().get(url);
  Map data = guinea_html.parseHTML(response.data);
  return mapToWidgets(context, data);
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_alert),
            tooltip: 'Show Snackbar',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const AboutPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: fetchAndRenderSite(
            context, "https://cbracco.github.io/html5-test-page/"),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            //shrinkWrap: true,
            child: Selectable(
              selectWordOnDoubleTap: true,
              child: Column(children: snapshot.data),
            ),
          );
        },
      ),
    );
  }
}
