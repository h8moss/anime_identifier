import 'dart:convert';

class ImageModel {
  ImageModel(this.tester);
  ImageModel.fromJson(Map<String, dynamic> json) : tester = jsonEncode(json);

  String tester;
}
