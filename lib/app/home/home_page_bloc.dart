import 'dart:io';

import 'package:anime_identifier/app/image_page/image_page.dart';
import 'package:anime_identifier/app/services/trace_moe_api.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:anime_identifier/app/common_widgets/simple_dialog.dart' as d;
import 'package:url_launcher/url_launcher.dart';

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
  final String _apiUrl = 'https://github.com/soruly/trace.moe-api';

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
      case HomePageEvent.startedLoading:
        yield HomePageModel(
            requests: state.requests, state: HomePageState.Loading);
        break;
      case HomePageEvent.finishedLoading:
        if (state.state == HomePageState.Loading) {
          yield HomePageModel(
              requests: state.requests, state: HomePageState.Working);
        }
        break;
      default:
        throw UnimplementedError();
    }
  }

  void onFromGallery(BuildContext context) async {
    bool shouldShowDialog = false;
    add(HomePageEvent.startedLoading);
    try {
      final pickedFile = await _picker.getImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final result = await _api.getImage(File(pickedFile.path));
        if (result != null)
          ImagePage.show(context, result);
        else
          shouldShowDialog = true;
      }
    } catch (e) {
      print(e);
      shouldShowDialog = true;
    }
    if (shouldShowDialog)
      d.SimpleDialog.show(
        context,
        title: 'Something went wrong',
        message: 'Please try again later',
      );
    add(HomePageEvent.finishedLoading);
  }

  Future<void> launchApiUrl() async {
    if (await canLaunch(_apiUrl)) await launch(_apiUrl);
  }
}
