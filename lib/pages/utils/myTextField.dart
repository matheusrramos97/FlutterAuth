import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String label;
  const MyTextField({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
          labelStyle: TextStyle(color: Theme.of(context).primaryColor)),
    );
  }
}
