import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData prefixIcon;
  const TextFormFieldWidget(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        textInputAction:
            labelText == 'Name' ? TextInputAction.next : TextInputAction.done,
        keyboardType:
            labelText == "Number" ? TextInputType.number : TextInputType.text,
        autocorrect: true,
        enableSuggestions: true,
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
          prefixIcon: Icon(prefixIcon),
        ),
      ),
    );
  }
}
