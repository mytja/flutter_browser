// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:ffi' as ffi;
import 'dart:io' show Platform, Directory;

import 'package:ffi/ffi.dart';
import 'package:path/path.dart' as path;

typedef HTMLToJSONFunc = ffi.Pointer<Utf8> Function(ffi.Pointer<Utf8>);
typedef HTMLToJSON = ffi.Pointer<Utf8> Function(ffi.Pointer<Utf8>);

typedef GetVersionFunc = ffi.Pointer<Utf8> Function();
typedef GetVersion = ffi.Pointer<Utf8> Function();

const libName = "libguineahtml";
const libPath = "GuineaHTML";

late ffi.DynamicLibrary dynamicLibrary;

void initializeLibrary() {
  // Open the dynamic library
  var libraryPath = path.join(Directory.current.path, libPath, '$libName.so');

  if (Platform.isMacOS) {
    libraryPath = path.join(Directory.current.path, libPath, '$libName.dylib');
  }

  if (Platform.isWindows) {
    libraryPath =
        path.join(Directory.current.path, libPath, 'Debug', '$libName.dll');
  }

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

String getVersion() {
  final GetVersion func = dynamicLibrary
      .lookup<ffi.NativeFunction<GetVersionFunc>>('GetVersion')
      .asFunction();

  final nativeResponse = func();
  String response = nativeResponse.toDartString();
  malloc.free(nativeResponse);

  return response;
}
