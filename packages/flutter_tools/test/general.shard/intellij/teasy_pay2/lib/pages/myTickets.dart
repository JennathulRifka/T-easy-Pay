// ignore_for_file: file_names

import 'package:flutter/material.dart';

class MyTicketsPage extends StatelessWidget {
  const MyTicketsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Tickets")),
      body: Center(child: Text("My Tickets Page")),
    );
  }
}
