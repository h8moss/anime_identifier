import 'package:anime_identifier/app/services/trace_moe_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app/home/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anime Identifier',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Provider<TraceMoeApi>(
        create: (_) => TraceMoeApi(),
        child: HomePage.create(context),
      ),
    );
  }
}
