import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';

import '../image_model.dart';

class TraceMoeApi {
  TraceMoeApi() {
    _getRequestsLeft();
  }

  StreamController<int> _requestsController = new StreamController.broadcast();
  Stream<int> get requests => _requestsController.stream;
  Dio _dio = Dio();

  void dispose() {
    _requestsController.close();
  }

  Future<ImageModel?> getImage(File f) async {
    FormData formData = FormData.fromMap(
        {'image': await MultipartFile.fromFile(f.path, filename: 'image.jpg')});

    Response res = await _dio.post(
      'https://api.trace.moe/search',
      data: formData,
    );
    await _getRequestsLeft();
    if (res.statusCode != null && res.statusCode! < 400) {
      if (res.data['error'].isEmpty) {
        return ImageModel.fromJson(res.data);
      }
    }
    return null;
  }

  Future<void> _getRequestsLeft() async {
    final response = await _dio.get('https://api.trace.moe/me');
    try {
      _requestsController.sink
          .add(response.data['quota'] - response.data['quotaUsed']);
    } catch (e) {
      print(e);
    }
  }
}
