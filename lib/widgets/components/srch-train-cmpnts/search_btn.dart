import 'package:flutter/material.dart';

class SearchBtn extends StatelessWidget {
  const SearchBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ElevatedButton(
        onPressed: () {
          // TODO: Implement search functionality
          // _searchTrains();
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
