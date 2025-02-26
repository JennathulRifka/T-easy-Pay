// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../widgets/floatingBottomBar.dart';


class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/'); // Home
        break;
      case 1:
        Navigator.pushNamed(context, '/booking'); // Booking
        break;
      case 2:
        Navigator.pushNamed(context, '/voice'); // Voice
        break;
      case 3:
        Navigator.pushNamed(context, '/notifications'); // Notifications
        break;
      case 4:
        Navigator.pushNamed(context, '/profile'); // Profile
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Booking")),
      body: Stack(
        children: [
          Center(child: Text("Booking Page")),
        ],
      ),
      //floating bottom bar
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 7),
        child: FloatingBottomBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ),
      ),
    );
  }
}
