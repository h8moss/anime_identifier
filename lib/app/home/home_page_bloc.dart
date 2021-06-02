import 'dart:io';

import 'package:anime_identifier/app/services/trace_moe_api.dart';
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
          yield HomePageModel(requests: newRequests!);
          newRequests = null;
        }
        break;
      default:
        throw UnimplementedError();
    }
  }

  void onFromGallery() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final result = await _api.getImage(File(pickedFile.path));
      print(result?.tester);
    }
  }
}
