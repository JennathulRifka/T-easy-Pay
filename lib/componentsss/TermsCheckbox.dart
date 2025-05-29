import 'package:flutter/material.dart';

class TermsCheckbox extends StatelessWidget {
  final bool value;
  final Function(bool?) onChanged;

  const TermsCheckbox({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: value, onChanged: onChanged),
        const Expanded(child: Text("I accept the Terms & Conditions", softWrap: true)),
      ],
    );
  }
}
