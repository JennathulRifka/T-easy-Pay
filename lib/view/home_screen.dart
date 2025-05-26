import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:teasy/view/search_train_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: isDarkMode ? Colors.black : Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome to T-Easy Pay!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.go('/searchTrain');
              },
              child: Text("Search Train"),
            ),
          ],
        ),
      ),
    );
  }
}
