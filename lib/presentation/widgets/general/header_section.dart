import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  final String title;
  const HeaderSection({super.key,required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children:  [
        Icon(
          Icons.local_parking,
          size: 80,
          color: Colors.white,
        ),
        SizedBox(height: 10),
        Text(
          title,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
