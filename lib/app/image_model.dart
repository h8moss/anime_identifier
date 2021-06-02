import 'dart:convert';

class ImageModel {
  ImageModel({
    required this.imageSource,
    required this.percentage,
    this.endTime,
    this.episode,
    this.startTime,
    this.title,
  });

  ImageModel.fromJson(Map<String, dynamic> json, String imageSource) {
    this.imageSource = imageSource;
    if (json['from'] != null)
      startTime = Duration(
          seconds: json['from'].round(),
          milliseconds: ((json['from'] - json['from'].round()) * 1000).round());
    if (json['to'] != null)
      endTime = Duration(
          seconds: json['to'].round(),
          milliseconds: ((json['to'] - json['to'].round()) * 1000).round());
    episode = json['episode'];
    if (json['anilist'].runtimeType == Map) {
      var jsonTitle = json['anilist']['title'];
      title = jsonTitle['english'] ?? jsonTitle['romanji'];
    }
    percentage = json['similarity'];
  }

  late String imageSource;
  int? episode;
  Duration? startTime;
  Duration? endTime;
  String? title;
  late double percentage;
}
