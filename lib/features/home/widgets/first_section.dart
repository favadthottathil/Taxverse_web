import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class FirstSection extends StatelessWidget {
  const FirstSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      color: Colors.blueGrey,
      width: double.infinity,
      child: Column(
        children: [
          Gap(100),
          Text(
            'IDEA! THATS TAXVERSE',
            style: TextStyle(
              fontSize: 50,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}