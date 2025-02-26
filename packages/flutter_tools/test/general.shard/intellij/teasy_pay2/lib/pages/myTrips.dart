// ignore_for_file: file_names

import 'package:flutter/material.dart';

class MyTripsPage extends StatelessWidget {
  const MyTripsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Trips")),
      body: Center(child: Text("My Trips Page")),
    );
  }
}