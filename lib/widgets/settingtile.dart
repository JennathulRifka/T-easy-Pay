import 'package:flutter/material.dart';
import 'package:car/widgets/selectoption.dart';

class Setting extends StatefulWidget {
  final String title;
  final String initialSubtitle;
  final VoidCallback? onTap;
  final Widget? trailing;
  final Alert? alertDialogContent;

  const Setting({
    super.key,
    required this.title,
    required this.initialSubtitle,
    this.onTap,
    this.trailing,
    this.alertDialogContent,
  });

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  late String currentSubtitle;

  @override
  void initState() {
    super.initState();
    currentSubtitle = widget.initialSubtitle;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
      subtitle: Text(currentSubtitle),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!();
        }
        if (widget.alertDialogContent != null) {
          showCustomAlertDialog(
            context,
            widget.alertDialogContent!,
            (selectedOption) {
              setState(() {
                currentSubtitle = "Selected: $selectedOption";
              });
            },
          );
        }
      },
    );
  }
}
