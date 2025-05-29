import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; 

class AdminHome extends StatelessWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 249, 250, 242),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Admin Home',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.yellow.shade700,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                context.go ('/startScreen');
              },
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                context.go('/newsManage');
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/news.png', // Ensure this is included in pubspec.yaml
                      height: 50,
                    ),
                    const SizedBox(width: 15),
                    const Expanded(
                      child: Text(
                        'Manage News',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.red,
                      size: 24,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
