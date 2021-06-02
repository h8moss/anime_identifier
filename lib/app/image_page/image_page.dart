import 'dart:io';

import 'package:anime_identifier/app/image_model.dart';
import 'package:flutter/material.dart';

class ImagePage extends StatelessWidget {
  const ImagePage({Key? key, required this.model}) : super(key: key);

  static void show(BuildContext context, ImageModel model) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => ImagePage(model: model)));
  }

  final ImageModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(children: [
      LinearProgressIndicator(value: model.percentage),
      Image.file(File(model.imageSource)),
      Row(
        children: [Text('Episode'), Text(model.episode.toString())],
      ),
      Row(
        children: [Text('Starts at: '), Text(model.startTime.toString())],
      ),
      Row(
        children: [Text('Ends at: '), Text(model.endTime.toString())],
      )
    ]));
  }
}
