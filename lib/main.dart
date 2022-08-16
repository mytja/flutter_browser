import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_browser/about.dart';
import 'package:flutter_browser/widgets/iframe.dart';
import 'package:guinea_html/guinea_html.dart' as guinea_html;
import 'package:selectable/selectable.dart';
import 'package:dart_vlc/dart_vlc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await guinea_html.initializeLibrary();
  await DartVLC.initialize(useFlutterNativeView: true);

  if (kReleaseMode) {
    debugPrint = (String? message, {int? wrapWidth}) {};
  }

  runApp(const MyApp());
}

//const TARGET_URL = "https://mytja.github.io/html5-css3-test-page/";
//const TARGET_URL = "https://google.com";

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterBrowser',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          bodyText1: TextStyle(fontSize: 14),
          bodyText2: TextStyle(fontSize: 14),
        ),
      ),
      home: const MyHomePage(title: 'FlutterBrowser'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //String url = "https://mytja.github.io/html5-css3-test-page/";
  String url = "https://html.duckduckgo.com/lite";

  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.text = url;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: [
          SizedBox(
            width: 800,
            child: TextField(
              decoration: const InputDecoration(icon: Icon(Icons.search)),
              controller: _controller,
              onSubmitted: (String value) async {
                setState(() {
                  _controller.text = value;
                });
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.info),
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
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: FutureBuilder(
            future: fetchAndRenderSite(
              context,
              _controller.text,
              _controller.text,
              callback: (String type, Map data) async {
                if (type == "newURL") {
                  debugPrint("User pressed a link ${data['url']}");
                  _controller.text = getCorrectURL(
                    data["url"],
                    _controller.text,
                  );
                  setState(() {});
                } else if (type == "resetForm") {
                  _formKey.currentState!.reset();
                } else if (type == "URLchange") {
                  debugPrint("Called URLchange with $data");
                  _controller.text = data["url"];
                }
              },
            ),
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
        ),
      ),
    );
  }
}
