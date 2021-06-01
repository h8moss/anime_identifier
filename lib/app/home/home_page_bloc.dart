import 'home_page_event.dart';
import 'home_page_model.dart';
import 'package:bloc/bloc.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageModel> {
  HomePageBloc(HomePageModel initialState) : super(initialState);

  @override
  Stream<HomePageModel> mapEventToState(event) {
    switch (state) {
      default:
        throw UnimplementedError();
    }
  }
}
