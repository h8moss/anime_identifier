import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../image_model.dart';

class TraceMoeApi {
  TraceMoeApi() {
    _getRequestsLeft();
  }

  final String domain = 'https://api.trace.moe';

  StreamController<int> _requestsController = new StreamController.broadcast();
  Stream<int> get requests => _requestsController.stream;
  Dio _dio = Dio();

  void dispose() {
    _requestsController.close();
  }

  Future<ImageModel?> getImageFromFile(File f) async {
    FormData formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(f.path, filename: 'image.jpg'),
    });

    Response res = await _dio.post(
      '$domain/search?anilistInfo',
      data: formData,
    );
    return await _getModel(res, Image.file(f));
  }

  Future<ImageModel?> getImageFromUrl(String s) async {
    String url = '$domain/search?anilistInfo&url=$s';
    Response res = await _dio.get(url);

    return await _getModel(res, Image.network(s));
  }

  Future<ImageModel?> _getModel(Response res, Widget widget) async {
    await _getRequestsLeft();
    if (res.statusCode != null && res.statusCode! < 400) {
      if (res.data['error'].isEmpty) {
        return ImageModel.fromJson(res.data['result'][0], widget);
      }
    }
    return null;
  }

  Future<void> _getRequestsLeft() async {
    final response = await _dio.get('$domain/me');
    try {
      _requestsController.sink
          .add(response.data['quota'] - response.data['quotaUsed']);
    } catch (e) {
      print(e);
    }
  }
}
