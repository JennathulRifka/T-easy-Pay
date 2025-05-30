import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:teasy/view/trainhistory.dart';

class TrainStation {
  final String name;
  final String arrivalTime;
  final String timeToNext;
  final bool isPassed;

  TrainStation({
    required this.name,
    required this.arrivalTime,
    required this.timeToNext,
    this.isPassed = false,
  });
}

class TrainTrackingScreen extends StatefulWidget {
  const TrainTrackingScreen({super.key});

  @override
  State<TrainTrackingScreen> createState() => _TrainTrackingScreenState();
}

class _TrainTrackingScreenState extends State<TrainTrackingScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<TrainStation> stations = [
    TrainStation(
      name: "Matara",
      arrivalTime: "10:00 AM",
      timeToNext: "15 min",
      isPassed: true,
    ),
    TrainStation(
      name: "Waligama",
      arrivalTime: "10:15 AM",
      timeToNext: "20 min",
      isPassed: true,
    ),
    TrainStation(name: "Galle", arrivalTime: "10:35 AM", timeToNext: "18 min"),
    TrainStation(
      name: "Panadura",
      arrivalTime: "10:53 AM",
      timeToNext: "12 min",
    ),
    TrainStation(
      name: "Colombo",
      arrivalTime: "11:05 AM",
      timeToNext: "Final Stop",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: _buildAppBar(),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Ongoing Trip Tab
          SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(),
                _buildTrainProgress(),
                _buildMapButton(),
              ],
            ),
          ),

          // History Tab
          _buildHistoryPage(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
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
        onPressed: () => context.pop(),
      ),
      title: Center(
        child: const Text(
          'My Trips',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_on_sharp, color: Colors.black),
          onPressed: () {},
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Container(
            height: 50,
            decoration: BoxDecoration(color: Colors.white),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Color(0xFFFFE175),
              ),
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorSize: TabBarIndicatorSize.tab, // Added this
              tabs: [
                SizedBox(
                  width: 150, // Specific width for the tab
                  child: const Tab(
                    child: Text('Ongoing Trip', textAlign: TextAlign.center),
                  ),
                ),
                SizedBox(
                  width: 150, // Specific width for the tab
                  child: const Tab(
                    child: Text('History', textAlign: TextAlign.center),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInfoCard("Train", "Express 507", Icons.train),
              _buildInfoCard("Journey", "Matara - Colombo", Icons.map),
              _buildInfoCard("Speed", "72 km/h", Icons.speed),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.black, size: 24),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(color: Colors.black54, fontSize: 12),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrainProgress() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Stack(
        children: [
          Positioned(
            left: 30,
            top: 0,
            bottom: 0,
            child: Container(
              width: 4,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.amber, Colors.amber.withOpacity(0.3)],
                  stops: const [0.4, 0.4],
                ),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Column(
            children: List.generate(
              stations.length,
              (index) => _buildStationIndicator(stations[index], index),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStationIndicator(TrainStation station, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: station.isPassed ? Colors.amber : Colors.white,
              border: Border.all(
                color:
                    station.isPassed
                        ? Colors.amber
                        : Colors.indigo.withOpacity(0.3),
                width: 4,
              ),
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    station.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildTimeInfo(
                        "Arrival",
                        station.arrivalTime,
                        Icons.access_time,
                      ),
                      if (index < stations.length - 1)
                        _buildTimeInfo(
                          "Next Station",
                          station.timeToNext,
                          Icons.timer,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeInfo(String label, String time, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.amber),
        const SizedBox(width: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
            Text(
              time,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMapButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.map, color: Colors.white),
        label: const Text("View on Map", style: TextStyle(color: Colors.white)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.amber,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}

Widget _buildHistoryPage() {
  return Column(
    children: [
      // Trip List
      Expanded(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'This Month',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
    ],
  );
}
