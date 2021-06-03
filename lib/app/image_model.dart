import 'package:flutter/material.dart';

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
          milliseconds:
              (((json['from'] - json['from'].round()) * 1000).round() / 100)
                  .round());
    if (json['to'] != null)
      endTime = Duration(
          seconds: json['to'].round(),
          milliseconds:
              (((json['to'] - json['to'].round()) * 1000).round() / 100)
                  .round());
    episode = json['episode'];
    print(json['anilist'].runtimeType);
    if (json['anilist'].runtimeType != int) {
      var jsonTitle = json['anilist']['title'];
      title = jsonTitle['english'] ?? jsonTitle['romanji'];
    }
    if (json['similarity'] > 0.5)
      // remove .5 to make it appear less sure when it's less sure
      percentage = (json['similarity'] - .5) / .5;
    else
      percentage = 0;
  }

  late String imageSource;
  int? episode;
  Duration? startTime;
  Duration? endTime;
  String? title;
  late double percentage;

  Color get confidenceColor {
    if (percentage < .85) return Colors.red;
    if (percentage < .9) return Colors.orange;
    if (percentage < .95) return Colors.green;
    return Colors.blue;
  }

  String get confidenceText {
    if (percentage < .50) return 'Terrible';
    if (percentage < .85) return 'Very poor';
    if (percentage < .9) return 'Poor';
    if (percentage < .95) return 'Good';
    return 'Great';
  }

  String get formatStart => _formatDuration(startTime);
  String get formatEnd => _formatDuration(endTime);

  String _formatDuration(Duration? d) {
    if (d == null) return 'Unknown';
    int h = d.inHours;
    int m = d.inMinutes % 60;
    int s = d.inSeconds % 60;
    int ms = d.inMilliseconds % 60;

    String sh = h > 9 ? '$h' : '0$h';
    String sm = m > 9 ? '$m' : '0$m';
    String ss = s > 9 ? '$s' : '0$s';
    String sms = ms > 9 ? '$ms' : '0$ms';

    if (h > 0) return '$sh:$sm:$ss.$sms';
    return '$sm:$ss.$sms';
  }
}
