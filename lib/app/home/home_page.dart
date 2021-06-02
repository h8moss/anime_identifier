import 'package:anime_identifier/app/services/trace_moe_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'home_page_bloc.dart';
import 'home_page_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Widget create(BuildContext context) {
    return BlocProvider<HomePageBloc>(
      create: (context) => HomePageBloc(
        HomePageModel(requests: 0),
        Provider.of<TraceMoeApi>(context, listen: false),
      ),
      child: HomePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<HomePageBloc>(context);
    return BlocBuilder<HomePageBloc, HomePageModel>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: Text('Anime identifier'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'You have ${state.requests} requests left',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () => bloc.onFromGallery(),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text('Select image from gallery'),
                      )),
                  SizedBox(height: 16),
                  Text('or', style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 16),
                  ElevatedButton(
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text('Submit Image Url'),
                      )),
                ],
              ),
              // TODO: make this a flat button to soruly's gh profile
              Text(
                'Using API by Soruly',
                style: TextStyle(decoration: TextDecoration.underline),
              )
            ],
          ),
        ),
      ),
    );
  }
}
