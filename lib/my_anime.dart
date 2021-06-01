import 'dart:convert';

import 'package:dio/dio.dart';
import 'dart:io';
import 'dart:typed_data';

void main() async {
  Dio dio = Dio();

  File file = File('./image.jpg');
  Uint8List bytes = file.readAsBytesSync();
  String bytesStr = base64.encode(bytes);
  Response res = await dio.post('https://trace.moe/api/search',
      data: {"image": "'$bytesStr'"},
      options: Options(headers: {"Content-Type": "application/json"}));

  print(res.data);
}
