// ignore_for_file: file_names
import 'package:flutter/material.dart';
import '../widgets/floatingBottomBar.dart';

class NewsFeedPage extends StatefulWidget {
  const NewsFeedPage({super.key});

  @override
  State<NewsFeedPage> createState() => _NewsFeedPageState();
}

class _NewsFeedPageState extends State<NewsFeedPage> {
  int _selectedIndex = 0;
  bool _isExpanded = false;

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
        title: const Text(
          "News Feed",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,

        leading: ModalRoute.of(context)?.settings.name == '/'
            ? null
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.yellow.shade700,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pushNamed(context, '/');
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                ),
              ),

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/notifications');
              },
              child: Stack(
                children: [
                  const Icon(
                    Icons.notifications, 
                    size: 30, color:  
                    Colors.black,
                  ),
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
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 8.0, bottom: 5),
                child: Text("Top News",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.yellow[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/newsfeed.png',
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _isExpanded
                          ? "The Ministry of Transport invites visionary investors to participate in an unprecedented opportunity to redefine the urban landscape by developing the six major railway stations, namely Slave Island, Kollupitiya, Bambalapitiya, Wallawatta, Dehiwala & Mount Lavinia through the PPP model.\n\n"
                              "Apart from this, investors have been given the opportunity to submit proposals for any railway station in Sri Lanka through the PPP format."
                          : "The Ministry of Transport invites visionary investors to participate in an unprecedented opportunity to redefine the urban landscape by developing the six major railway stations, namely Slave Island, Kollupitiya, Bambalapitiya, Wallawatta, Dehiwala & Mount Lavinia...",
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 5),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow[700],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _isExpanded = !_isExpanded;
                          });
                        },
                        child: Text(
                          _isExpanded ? "Read Less" : "Read More",
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

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
