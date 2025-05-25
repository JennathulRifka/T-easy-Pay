import 'package:flutter/material.dart';

class TrainImg extends StatefulWidget {
  const TrainImg({super.key});

  @override
  State<TrainImg> createState() => _TrainImgState();
}

class _TrainImgState extends State<TrainImg> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        "assets/images/train_detail_img.jpg",
        width: 323,
        height: 138,
        fit: BoxFit.cover,
      ),
    );
  }
}
