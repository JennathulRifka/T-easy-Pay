import 'package:flutter/material.dart';

class Alert {
  final String title;
  final String content;
  final String option1;
  final String option2;
  final String saveText;

  const Alert({
    required this.title,
    required this.content,
    this.option1 = 'Option 1',
    this.option2 = 'Option 2',
    this.saveText = 'Save',
  });
}

void showCustomAlertDialog(
  BuildContext context,
  Alert content,
  Function(String) onSave,
) {
  String? selectedOption;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text(content.title),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(content.content),
                const SizedBox(height: 16),
                RadioListTile<String>(
                  title: Text(content.option1),
                  value: content.option1,
                  groupValue: selectedOption,
                  onChanged: (value) {
                    setState(() {
                      selectedOption = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: Text(content.option2),
                  value: content.option2,
                  groupValue: selectedOption,
                  onChanged: (value) {
                    setState(() {
                      selectedOption = value;
                    });
                  },
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                child: Text(content.saveText),
                onPressed: () {
                  if (selectedOption != null) {
                    Navigator.of(context).pop();
                    onSave(selectedOption!);
                  }
                },
              ),
            ],
          );
        },
      );
    },
  );
}
