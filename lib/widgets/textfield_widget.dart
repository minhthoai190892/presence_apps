import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    Key? key,
    required this.controller, required this.title,
  }) : super(key: key);

  final TextEditingController? controller;
  final String title;
  @override
  Widget build(BuildContext context) {
    return TextField(
      autocorrect: false,
      controller: controller,
      decoration:  InputDecoration(
        border: const OutlineInputBorder(),
        labelText: title,
      ),
    );
  }
}
