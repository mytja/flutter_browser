// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:ffi' as ffi;
import 'dart:io' show Directory, File, Platform;

import 'package:ffi/ffi.dart';
import 'package:path/path.dart' as path;

typedef HTMLToJSONFunc = ffi.Pointer<Utf8> Function(ffi.Pointer<Utf8>);
typedef HTMLToJSON = ffi.Pointer<Utf8> Function(ffi.Pointer<Utf8>);

typedef CSSToJSONFunc = ffi.Pointer<Utf8> Function(ffi.Pointer<Utf8>);
typedef CSSToJSON = ffi.Pointer<Utf8> Function(ffi.Pointer<Utf8>);

typedef GetVersionFunc = ffi.Pointer<Utf8> Function();
typedef GetVersion = ffi.Pointer<Utf8> Function();

const libName = "libguineahtml";
const libPath = "GuineaHTML";

late ffi.DynamicLibrary dynamicLibrary;

Future<void> initializeLibrary() async {
  String libraryPath;

  if (Platform.isLinux) {
    if (await File(path.join(Directory.current.path, "lib", '$libName.so'))
        .exists()) {
      libraryPath = path.join(Directory.current.path, "lib", '$libName.so');
    } else if (await File(
            path.join(Directory.current.path, libPath, '$libName.so'))
        .exists()) {
      libraryPath = path.join(Directory.current.path, libPath, '$libName.so');
    } else if (await File(
            path.join(Directory.current.parent.path, '$libName.so'))
        .exists()) {
      libraryPath = path.join(Directory.current.parent.path, '$libName.so');
    } else if (await File(
            path.join(Directory.current.parent.parent.path, '$libName.so'))
        .exists()) {
      libraryPath =
          path.join(Directory.current.parent.parent.path, '$libName.so');
    } else if (await File(path.join(
            Directory.current.parent.parent.parent.parent.parent.path,
            libPath,
            '$libName.so'))
        .exists()) {
      libraryPath = path.join(
          Directory.current.parent.parent.parent.parent.parent.path,
          libPath,
          '$libName.so');
    } else if (await File('/usr/lib/x86_64-linux-gnu/$libName.so').exists()) {
      libraryPath = '/usr/lib/x86_64-linux-gnu/$libName.so';
    } else if (await File('/usr/lib/$libName.so').exists()) {
      libraryPath = '/usr/lib/$libName.so';
    } else if (await File('/usr/lib64/$libName.so').exists()) {
      libraryPath = '/usr/lib64/$libName.so';
      return;
    } else {
      throw Exception(
          "Unable to locate libguineahtml. Please make sure it's installed on your system.");
    }
  } else if (Platform.isWindows) {
    print(
        "[WARNING] Support for Windows by libguineahtml is very limited. It will most likely work, but you can't count on official support.");
    if (await File(path.join(
      Directory.current.path,
      libPath,
      'Debug',
      '$libName.dll',
    )).exists()) {
      libraryPath =
          path.join(Directory.current.path, libPath, 'Debug', '$libName.dll');
    } else {
      throw Exception(
          "Unable to locate libguineahtml. Please make sure it's installed on your system.");
    }
  } else if (Platform.isMacOS) {
    print(
        "[WARNING] MacOS isn't supported at all by libguineahtml. It's posible that it's working, but you can't count on official support.");
    if (await File(path.join(Directory.current.path, libPath, '$libName.dylib'))
        .exists()) {
      libraryPath =
          path.join(Directory.current.path, libPath, '$libName.dylib');
    } else {
      throw Exception(
          "Unable to locate libguineahtml. Please make sure it's installed on your system.");
    }
  } else {
    throw Exception("Unsupported platform");
  }

  print("Using dynamic library $libraryPath");

  dynamicLibrary = ffi.DynamicLibrary.open(libraryPath);
}

Map parseHTML(String body) {
  final HTMLToJSON func = dynamicLibrary
      .lookup<ffi.NativeFunction<HTMLToJSONFunc>>('HTMLToJSON')
      .asFunction();

  final nativeBody = body.toNativeUtf8();
  final nativeResponse = func(nativeBody);
  String response = nativeResponse.toDartString();

  malloc.free(nativeBody);
  malloc.free(nativeResponse);

  return jsonDecode(response);
}

List parseCSS(String body) {
  final CSSToJSON func = dynamicLibrary
      .lookup<ffi.NativeFunction<CSSToJSONFunc>>('CSSToJSON')
      .asFunction();

  final nativeBody = body.toNativeUtf8();
  final nativeResponse = func(nativeBody);
  String response = nativeResponse.toDartString();

  malloc.free(nativeBody);
  malloc.free(nativeResponse);

  List responseDecoded = jsonDecode(response);

  print(responseDecoded);

  return responseDecoded;
}

String getVersion() {
  final GetVersion func = dynamicLibrary
      .lookup<ffi.NativeFunction<GetVersionFunc>>('GetVersion')
      .asFunction();

  final nativeResponse = func();
  String response = nativeResponse.toDartString();
  malloc.free(nativeResponse);

  return response;
}
