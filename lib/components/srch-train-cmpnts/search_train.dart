import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teasypay_kd/components/srch-train-cmpnts/station_picker.dart';
import 'package:teasypay_kd/repositories/station_repository.dart';
import 'package:teasypay_kd/viewmodels/search_train_view_model.dart';

class SearchTrain extends StatelessWidget {
  const SearchTrain({super.key});

  @override
  Widget build(BuildContext context) {
    final searchModel = Provider.of<TrainSearchViewModel>(context);
    final fromStation = searchModel.fromStation;
    final toStation = searchModel.toStation;
    final selectedDate = searchModel.departureDate;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.amber[50],
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        children: [
          // From station
          _StationField(
              label: 'From',
              value: fromStation.isEmpty
                  ? 'Select departure station'
                  : fromStation,
              onTap: () async {
                final stationList =
                    await StationRepository().fetchStationNames();

                final selected = await showDialog<String>(
                  context: context,
                  builder: (_) => StationPickerDialog(
                    stations: stationList,
                  ),
                );

                if (selected != null) {
                  searchModel.setFromStation(selected);
                }
              }),

          const SizedBox(height: 10),

          // To station
          _StationField(
              label: 'To',
              value: toStation.isEmpty ? 'Select arrival station' : toStation,
              onTap: () async {
                final stationList =
                    await StationRepository().fetchStationNames();

                final selected = await showDialog<String>(
                  context: context,
                  builder: (_) => StationPickerDialog(
                    stations: stationList,
                  ),
                );

                if (selected != null) {
                  searchModel.setToStation(selected);
                }
              }),

          const SizedBox(height: 10),

          // Date
          _DateField(
            selectedDate: selectedDate,
            onTap: () async {
              final now = DateTime.now();
              final picked = await showDatePicker(
                context: context,
                initialDate: selectedDate ?? now,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 90)),
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: ColorScheme.light(
                        primary:
                            Colors.amber, // header background & active date
                        onPrimary: Colors.white, // header text color
                        onSurface: Colors.black, // default text color
                      ),
                      dialogBackgroundColor:
                          Colors.amber[50], // background color of the dialog
                    ),
                    child: child!,
                  );
                },
              );

              if (picked != null) {
                searchModel.setDepartureDate(picked);
              }
            },
          ),
        ],
      ),
    );
  }
}

class _StationField extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onTap;

  const _StationField({
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        Container(
          margin: const EdgeInsets.only(top: 4),
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 14),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.amber.shade700),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            children: [
              Icon(Icons.train, color: Colors.amber.shade800),
              const SizedBox(width: 8),
              Expanded(
                child: GestureDetector(
                  onTap: onTap,
                  child: Text(
                    value,
                    style: TextStyle(
                      color: value.startsWith('Select')
                          ? Colors.grey
                          : Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DateField extends StatelessWidget {
  final DateTime? selectedDate;
  final VoidCallback onTap;

  const _DateField({
    required this.selectedDate,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final displayText = selectedDate == null
        ? '+ Add departure date'
        : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Departure',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        Container(
          margin: const EdgeInsets.only(top: 4),
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 14),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.amber.shade700),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            children: [
              Text(displayText,
                  style: TextStyle(
                      color:
                          selectedDate == null ? Colors.grey : Colors.black)),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.calendar_today, size: 20),
                onPressed: onTap,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
