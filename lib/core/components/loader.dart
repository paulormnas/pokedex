import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  final String message;
  const Loader(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const SizedBox(
        width: 60,
        height: 60,
        child: CircularProgressIndicator(),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Text(message),
      ),
    ]));
  }
}
