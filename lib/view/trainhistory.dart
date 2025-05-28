import 'package:flutter/material.dart';



class TripHistoryScreen extends StatelessWidget {
  const TripHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Color(0xFFFFE175),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_back, color: Colors.black),
            ),
            onPressed: () {},
          ),
          title: const Text(
            'My Trips',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_outlined, color: Colors.black),
              onPressed: () {},
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: TabBar(
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.grey.shade100,
                  ),
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  tabs: const [
                    Tab(text: 'Ongoing Trip'),
                    Tab(text: 'History'),
                  ],
                ),
              ),
            ),
          ),
        ),
      body: Column(
        children: [
          // Tab Buttons
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: const Text(
                      'Ongoing Trip',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: const Text(
                      'History',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Trip List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text(
                  'This Month',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                TripCard(
                  from: 'Colombo',
                  to: 'Badulla',
                  trainNumber: '1005 Podi Menike',
                  date: '26/09/2024',
                  departureTime: '05:55',
                  passengers: 4,
                  trainClass: '1st Class',
                  color: const Color(0xFFFFF8E1),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Last Month',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                TripCard(
                  from: 'Colombo',
                  to: 'Kandy',
                  trainNumber: '1015 Udarata Menike',
                  date: '10/08/2024',
                  departureTime: '08:30',
                  passengers: 2,
                  trainClass: '2nd Class',
                  color: const Color(0xFFE3F2FD),
                ),
                const SizedBox(height: 12),
                TripCard(
                  from: 'Colombo',
                  to: 'Matara',
                  trainNumber: '1015 Udarata Menike',
                  date: '05/08/2024',
                  departureTime: '10:30',
                  passengers: 1,
                  trainClass: '2nd Class',
                  color: const Color(0xFFFCE4EC),
                ),
              ],
            ),
          ),
          
          // Bottom Navigation Bar
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 10,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.home_outlined, color: Colors.grey[600]),
                  Icon(Icons.bookmark_outline, color: Colors.grey[600]),
                  Icon(Icons.mic_none, color: Colors.grey[600]),
                  Icon(Icons.remove, color: Colors.grey[600]),
                  Icon(Icons.menu, color: Colors.grey[600]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TripCard extends StatelessWidget {
  final String from;
  final String to;
  final String trainNumber;
  final String date;
  final String departureTime;
  final int passengers;
  final String trainClass;
  final Color color;

  const TripCard({
    super.key,
    required this.from,
    required this.to,
    required this.trainNumber,
    required this.date,
    required this.departureTime,
    required this.passengers,
    required this.trainClass,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.train, size: 40),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$from to $to',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    trainNumber,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date : $date',
                    style: const TextStyle(fontSize: 14),
                  ),
                  Text(
                    'Departed: $departureTime',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Passengers : $passengers',
                    style: const TextStyle(fontSize: 14),
                  ),
                  Text(
                    'Class : $trainClass',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}