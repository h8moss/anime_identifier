import 'package:anime_identifier/app/services/trace_moe_api.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:anime_identifier/app/common_widgets/simple_dialog.dart' as d;

import '../image_model.dart';

class UrlPageCubit extends Cubit<bool> {
  UrlPageCubit(bool initialState, this.api) : super(initialState);

  final TraceMoeApi api;

  void onTextChange(String str) => emit(str.isNotEmpty);

  Future<void> onSubmit(BuildContext context, String str) async {
    emit(false);
    bool shouldShowDialog = false;
    ImageModel? model;
    try {
      model = await api.getImageFromUrl(str);
      Navigator.of(context).pop(model);
    } catch (e) {
      shouldShowDialog = true;
    }
    if (model == null) shouldShowDialog = true;
    emit(true);
    if (shouldShowDialog)
      d.SimpleDialog.show(context,
          title: 'Something went wrong',
          message: 'Please try with a different Url');
  }
}
