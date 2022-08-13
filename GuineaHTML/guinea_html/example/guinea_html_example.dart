import 'package:dio/dio.dart';
import 'package:guinea_html/guinea_html.dart';

void main() async {
  initializeLibrary();
  var response = await Dio().get('https://cbracco.github.io/html5-test-page/');
  print(parseHTML(response.data));
}
