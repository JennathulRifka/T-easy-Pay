import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:teasy/viewmodels/search_train_view_model.dart';
import 'package:teasy/viewmodels/train_view_model.dart';

class SearchBtn extends StatelessWidget {
  const SearchBtn({super.key});

  @override
  Widget build(BuildContext context) {
    final searchViewModel = Provider.of<TrainSearchViewModel>(context);
    final trainViewModel = Provider.of<TrainViewModel>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ElevatedButton(
        onPressed: () async {
          final fromStation = searchViewModel.fromStation;
          final toStation = searchViewModel.toStation;
          final selectedDate = searchViewModel.departureDate;

          if (fromStation.isEmpty ||
              toStation.isEmpty ||
              selectedDate == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Please select all fields")),
            );
            return;
          }

          await trainViewModel.loadTrains(
            departure: fromStation,
            arrival: toStation,
          );

          context.push(
            '/selectTrain',
            extra: {
              'fromStation': fromStation,
              'toStation': toStation,
              'departureDate': selectedDate,
            },
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.amber,
          minimumSize: const Size.fromHeight(50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: const Text(
          'Search Train',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
