import 'package:flutter/material.dart';

class OfferCard extends StatelessWidget {
  final String imagePath;

  const OfferCard({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.amber[200],
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.grey, blurRadius: 2, offset: Offset(2, 2))
          ]),
      height: 140,
      width: 270,
      child: Image.asset(imagePath, width: 266, height: 131),
    );
  }
}
