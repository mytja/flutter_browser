// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_browser/constants/useragent.dart';
import 'package:flutter_browser/widgets/css.dart';
import 'package:flutter_browser/widgets/mapper.dart';
import 'package:guinea_html/guinea_html.dart' as guinea_html;
import 'package:selectable/selectable.dart';

final options = BaseOptions(headers: {HttpHeaders.userAgentHeader: USER_AGENT});

String getCorrectURL(String url, String parentUrl) {
  debugPrint("Parsing URL $url to parent URL $parentUrl");
  if (!parentUrl.isNotEmpty) {
    throw Exception("invalid URL - url $url, parentUrl $parentUrl");
  }
  if (url.startsWith("//")) {
    // I don't give a fine f about http
    // If you're not using https in 2022, then idk what are you doing in your life
    url = "https:$url";
  }
  String hitUrl;
  Uri parsedUrl = Uri.parse(url);
  Uri parsedParentUrl = Uri.parse(parentUrl);
  if (parsedUrl.isAbsolute) {
    hitUrl = url;
  } else {
    if (url.isNotEmpty && url[0] == "/") {
      hitUrl = "${parsedParentUrl.origin}$url";
    } else if (url.isEmpty) {
      hitUrl = parentUrl;
    } else {
      hitUrl = "$parentUrl/$url";
    }
  }
  return hitUrl;
}

Future<List<Widget>> fetchAndRenderSite(
    BuildContext context, String parentUrl, String url,
    {int iFrameDepth = 1,
    required Future<void> Function(String type, Map data) callback,
    String method = "get",
    String requestBody = ""}) async {
  if (iFrameDepth > 2) {
    return [];
  }
  String hitUrl = getCorrectURL(url, parentUrl);
  debugPrint("Hitting url $hitUrl");
  Response response;
  try {
    if (method == "get") {
      response = await Dio(options).get(hitUrl);
    } else if (method == "post") {
      response = await Dio(options).post(
        hitUrl,
        data: requestBody,
        options: Options(
          headers: {
            Headers.contentTypeHeader: "application/x-www-form-urlencoded",
          },
        ),
      );
    } else {
      throw Exception("Not implemented");
    }
  } catch (e) {
    return [];
  }
  debugPrint("Done requesting");
  if (response.redirects.isNotEmpty) {
    hitUrl = response.redirects.last.location.toString();
    await callback(
      "URLchange",
      {"url": hitUrl},
    );
  }
  Map data = guinea_html.parseHTML(response.data);
  return await mapToWidgets(
    context,
    data,
    hitUrl,
    callback,
    CSSOptions([]),
    iFrameDepth: iFrameDepth,
  );
}

class GuineaIFrame extends StatelessWidget {
  const GuineaIFrame({
    Key? key,
    required this.url,
    required this.parentUrl,
    required this.iFrameDepth,
    required this.callback,
  }) : super(key: key);

  final String url;
  final String parentUrl;
  final int iFrameDepth;
  final Future<void> Function(String type, Map data) callback;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      height: 500,
      child: SingleChildScrollView(
        child: FutureBuilder(
          future: fetchAndRenderSite(
            context,
            parentUrl,
            url,
            callback: callback,
            iFrameDepth: iFrameDepth + 1,
          ),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (iFrameDepth > 2) {
              return Center(
                child: Column(
                  children: const [
                    Text(
                      "(^-^*)",
                      style: TextStyle(fontSize: 40),
                    ),
                    Text(
                      "Due to the policy of FlutterBrowser, you cannot render more than one iFrame",
                    ),
                  ],
                ),
              );
            }
            if (snapshot.hasData) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                //shrinkWrap: true,
                child: Selectable(
                  selectWordOnDoubleTap: true,
                  child: Column(children: snapshot.data),
                ),
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
