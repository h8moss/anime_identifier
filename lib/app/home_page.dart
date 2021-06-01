import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Anime identifier'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('You have 10 requests left'),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text('Select image from gallery'),
                      )),
                  SizedBox(height: 16),
                  Text('or'),
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
              Text('Using API by Soruly')
            ],
          ),
        ));
  }
}
