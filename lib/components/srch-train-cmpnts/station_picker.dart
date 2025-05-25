import 'package:flutter/material.dart';

class StationPickerDialog extends StatelessWidget {
  final List<String> stations;

  const StationPickerDialog({super.key, required this.stations});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Station'),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: stations.length,
          itemBuilder: (context, index) {
            final station = stations[index];
            return ListTile(
              title: Text(station),
              onTap: () => Navigator.pop(context, station),
            );
          },
        ),
      ),
    );
  }
}
