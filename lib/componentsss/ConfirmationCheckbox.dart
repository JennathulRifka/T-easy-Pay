import 'package:flutter/material.dart';

class ConfirmationCheckbox extends StatelessWidget {
  final bool value;
  final Function(bool?) onChanged;

  const ConfirmationCheckbox({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: value, onChanged: onChanged),
        const Expanded(child: Text("Are you sure? Please confirm the above details again", softWrap: true)),
      ],
    );
  }
}
