import 'package:flutter/material.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 16.0),
      child: Text(
        '© 2025 Pumba. All rights reserved.',
        style: TextStyle(color: Colors.white60),
        textAlign: TextAlign.center,
      ),
    );
  }
}
