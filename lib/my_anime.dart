// this file is just to test the functionality of the API
// TODO: Remove file
import 'dart:convert';

import 'package:dio/dio.dart';
import 'dart:io';
import 'dart:typed_data';

void main() async {
  Dio dio = Dio();

  FormData formData = FormData.fromMap({
    'image': await MultipartFile.fromFile('./image.jpg', filename: 'image.jpg')
  });

  Response res = await dio.post(
    'https://api.trace.moe/search',
    data: formData,
  );
  print(res.data);
}
