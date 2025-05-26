import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:teasy/widgets/floatingBottomBar.dart';
import 'package:teasy/components/srch-train-cmpnts/offer_card.dart';
import 'package:teasy/components/srch-train-cmpnts/search_btn.dart';
import 'package:teasy/components/srch-train-cmpnts/search_train.dart';
// <-- import your nav bar

class SearchTrainScreen extends StatefulWidget {
  const SearchTrainScreen({super.key});

  @override
  _SearchTrainScreenState createState() => _SearchTrainScreenState();
}

class _SearchTrainScreenState extends State<SearchTrainScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("🔥 Firebase is Ready!"),
          duration: Duration(seconds: 3),
        ),
      );
    });
  }

  void _handleNavTap(int index) {
    switch (index) {
      case 0:
        context.go('/homePage');
        break;
      case 1:
        // Already on search screen
        break;
      case 2:
        // Mic action
        break;
      case 3:
        context.go('/profile');
        break;
      case 4:
        context.go('/menu');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          width: 36,
          height: 36,
          margin: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: Colors.amber,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: () {
              context.go('/homePage'); // Navigate back to the previous screen
            },
            icon: const Icon(Icons.arrow_back, size: 25, weight: 600),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ),
        title: const Text(
          'Search Train',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications, color: Colors.black),
          )
        ],
      ),
      body: Stack(
        children: [
          /// Scrollable content
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 90),
            child: Center(
              child: Container(
                margin: const EdgeInsets.all(12),
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    const SearchTrain(),
                    const SizedBox(height: 12),
                    const SearchBtn(),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Hot Offer",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        TextButton(
                          onPressed: () {
                            context.push('/offerDetails');
                          },
                          child: const Text(
                            "See more",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          4,
                          (index) => const Padding(
                            padding: EdgeInsets.only(right: 12.0),
                            child: OfferCard(
                                imagePath: "assets/images/offer_img1.PNG"),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),

          /// Floating Bottom Navigation Bar (component)
          Positioned(
            bottom: 10,
            left: 20,
            right: 20,
            child: FloatingBottomBar(
              selectedIndex: 1, // highlight current screen
              onItemTapped: _handleNavTap,
            ),
          ),
        ],
      ),
    );
  }
}
