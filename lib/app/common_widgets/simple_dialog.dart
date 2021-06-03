import 'package:flutter/material.dart';

class SimpleDialog extends StatelessWidget {
  const SimpleDialog({
    Key? key,
    required this.title,
    this.message,
  }) : super(key: key);

  final String title;
  final String? message;

  static void show(BuildContext context,
      {required String title, String? message}) {
    showDialog(
        context: context,
        builder: (_) => SimpleDialog(title: title, message: message));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: message != null ? Text(message!) : null,
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(), child: Text('ok'))
      ],
    );
  }
}
