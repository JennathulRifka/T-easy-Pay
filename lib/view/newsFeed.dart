// ignore_for_file: file_names
import 'package:flutter/material.dart';
import '../widgets/floatingBottomBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewsFeedPage extends StatefulWidget {
  const NewsFeedPage({super.key});

  @override
  State<NewsFeedPage> createState() => _NewsFeedPageState();
}

class _NewsFeedPageState extends State<NewsFeedPage> {
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
                    size: 30,
                    color: Colors.black,
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
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('news')
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final newsDocs = snapshot.data!.docs;

                  return Column(
                    children: newsDocs.map((doc) {
                      return NewsCard(data: doc.data() as Map<String, dynamic>);
                    }).toList(),
                  );
                },
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

class NewsCard extends StatefulWidget {
  final Map<String, dynamic> data;

  const NewsCard({super.key, required this.data});

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final timestamp = (widget.data['timestamp'] as Timestamp?)?.toDate();
    final duration =
        timestamp != null ? DateTime.now().difference(timestamp) : null;
    final timeAgo = duration != null
        ? '${duration.inHours > 0 ? '${duration.inHours} hours ago' : '${duration.inMinutes} minutes ago'}'
        : 'Just now';

    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.yellow[100],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.data['imagePath'] != null &&
                widget.data['imagePath'].toString().isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  widget.data['imagePath'],
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 10),
            Text(
              widget.data['title'] ?? '',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 5),
            Text(
              widget.data['content'] ?? '',
              maxLines: isExpanded ? null : 3,
              overflow:
                  isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  timeAgo,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.yellow[700],
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                  onPressed: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  child: Text(
                    isExpanded ? 'Read less' : 'Read more',
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
