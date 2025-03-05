// ignore_for_file: file_names

import 'package:flutter/material.dart';

class FloatingBottomBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const FloatingBottomBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 10,
      left: 20,
      right: 20,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Stack(
          children: [
            Container(
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(95, 68, 65, 65),
                    blurRadius: 10,
                    spreadRadius: 3,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
            ),
        
            // Navigation Bar
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Container(
                height: 70,
                color: Colors.white,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        IconButton(
                          icon: Icon(Icons.home_filled, size: 30),
                          color: Colors.yellow.shade700,
                          onPressed: () => onItemTapped(0),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                        ),
                        IconButton(
                          icon: Icon(Icons.book, size: 30),
                          color: Colors.yellow.shade700,
                          padding: EdgeInsets.only(right: 15),
                          onPressed: () => onItemTapped(1),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                        ),
                        SizedBox(width: 40),
                        IconButton(
                          icon: Icon(Icons.account_circle, size: 30),
                          color: Colors.yellow.shade700,
                          padding: EdgeInsets.only(left: 20),
                          onPressed: () => onItemTapped(3),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                        ),
                        IconButton(
                          icon: Icon(Icons.menu, size: 30,),
                          color: Colors.yellow.shade700,
                          onPressed: () => onItemTapped(4),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                        ),
                      ],
                    ),
        
                    // Floating Mic Button
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 0,
                      child: Center(
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 2.5),
                          decoration: BoxDecoration(
                            color: Colors.yellow.shade700,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(96, 85, 81, 81),
                                blurRadius: 7,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: IconButton(
                            icon: Icon(Icons.mic, size: 50, color: Colors.white),
                            onPressed: () {onItemTapped(2);},
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
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
