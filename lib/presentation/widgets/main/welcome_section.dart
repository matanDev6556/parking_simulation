import 'package:flutter/material.dart';
import 'package:pumba_ex/data/models/user_model.dart';

class WelcomeCard extends StatelessWidget {
  const WelcomeCard({
    super.key,
    required this.userModel,
    required this.subText,
  });

  final UserModel userModel;
  final String subText;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.white.withOpacity(0.9),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Welcome',
              style: TextStyle(fontSize: 18, color: Color(0xFF0A2472)),
            ),
            SizedBox(height: 8),
            Text(
              '${userModel.firstName} ${userModel.lastName}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0A2472),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              subText,
              style: TextStyle(fontSize: 18, color: Color(0xFF0A2472)),
            ),
          ],
        ),
      ),
    );
  }
}