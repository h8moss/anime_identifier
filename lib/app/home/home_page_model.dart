import 'package:flutter/cupertino.dart';

enum HomePageState {
  Working,
  Loading,
  Off,
}

@immutable
class HomePageModel {
  HomePageModel({this.requests: 0, this.state: HomePageState.Working});

  final int requests;
  final HomePageState state;
}
