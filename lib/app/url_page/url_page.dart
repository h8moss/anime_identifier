import 'package:anime_identifier/app/image_model.dart';
import 'package:anime_identifier/app/services/trace_moe_api.dart';
import 'package:anime_identifier/app/url_page/url_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UrlPage extends StatefulWidget {
  const UrlPage({Key? key}) : super(key: key);

  static Future<ImageModel?> show(BuildContext context, TraceMoeApi api) async {
    return await Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => BlocProvider(
        create: (_) => UrlPageCubit(false, api),
        child: UrlPage(),
      ),
    ));
  }

  @override
  _UrlPageState createState() => _UrlPageState();
}

class _UrlPageState extends State<UrlPage> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<UrlPageCubit>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Submit Url'),
        ),
        body: BlocBuilder<UrlPageCubit, bool>(
          builder: (context, state) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Text('Url of the image')),
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _controller,
                  onChanged: cubit.onTextChange,
                ),
              )),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    Expanded(
                        child: ElevatedButton(
                            child: Text('Submit'),
                            onPressed: state
                                ? () =>
                                    cubit.onSubmit(context, _controller.text)
                                : null))
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
