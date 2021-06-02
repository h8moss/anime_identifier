import 'dart:io';

import 'package:anime_identifier/app/image_page/image_page.dart';
import 'package:anime_identifier/app/services/trace_moe_api.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'home_page_event.dart';
import 'home_page_model.dart';
import 'package:bloc/bloc.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageModel> {
  HomePageBloc(HomePageModel initialState, this._api) : super(initialState) {
    _api.requests.listen((event) {
      newRequests = event;
      add(HomePageEvent.requestsChanged);
    });
  }

  int? newRequests;
  final _picker = ImagePicker();
  final TraceMoeApi _api;

  @override
  Stream<HomePageModel> mapEventToState(event) async* {
    switch (event) {
      case HomePageEvent.requestsChanged:
        if (newRequests != null) {
          yield HomePageModel(
              requests: newRequests!,
              state: newRequests == 0 ? HomePageState.Off : state.state);
          newRequests = null;
        }
        break;
      default:
        throw UnimplementedError();
    }
  }

  void onFromGallery(BuildContext context) async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final result = await _api.getImage(File(pickedFile.path));
      if (result != null) ImagePage.show(context, result);
    }
  }
}
