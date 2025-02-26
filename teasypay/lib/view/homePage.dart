// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../widgets/floatingBottomBar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.all(0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/profile');
                },
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/profile.jpg'),
                      radius: 20,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Pasindu",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      " Piyumika",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/notifications');
                },
                child: Stack(
                  children: [
                    Icon(Icons.notifications, size: 30),
                    Positioned(
                      top: 2,
                      right: 2,
                      child: CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      body: Column(
        children: [
          // Banner Image
          Container(
            margin: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: AssetImage('assets/train_banner.png'),
              ),
            ),
            height: 300,
            width: 368,
          ),

          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 10,
              bottom: 10,
            ),
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              childAspectRatio: 1.2,
              children: [
                _menuItem(context, "News Feed", 'assets/news.png', '/newsFeed',90, 90),
                _menuItem(context, "Train Schedule", 'assets/schedule.png', '/trainSchedule', 90, 90),
                _menuItem(context, "My Trips", 'assets/trips.png', '/myTrips', 90, 90),
                _menuItem(context, "My Tickets", 'assets/tickets.png', '/myTickets', 90, 90),
              ],
            ),
          ),
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

  Widget _menuItem(BuildContext context, String title, String imagePath,
      String route, double imgWidth, double imgHeight) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.yellow.shade700, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, width: imgWidth, height: imgHeight),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
