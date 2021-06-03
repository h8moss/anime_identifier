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
        appBar: AppBar(
          title: Text(model.title ?? 'Unknown'),
        ),
        body: ListView(
          children: [
            Center(child: Text('Confidence', style: TextStyle(fontSize: 19))),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: LinearProgressIndicator(
                value: model.percentage,
                minHeight: 15,
                color: model.confidenceColor,
                backgroundColor: model.confidenceColor.withAlpha(122),
              ),
            ),
            Center(
                child: Text(model.confidenceText,
                    style:
                        TextStyle(color: model.confidenceColor, fontSize: 19))),
            model.imageWidget,
            _buildListText('Source: ${model.title ?? 'unknown'}'),
            _buildListText('Episode: ${model.episode ?? 'unknown'}'),
            _buildListText('Starts at: ${model.formatStart}'),
            _buildListText('Ends at: ${model.formatEnd}'),
          ],
        ));
  }

  Widget _buildListText(String text) => Column(
        children: [
          Center(child: Text(text, style: TextStyle(fontSize: 19))),
          Divider(),
        ],
      );
}
