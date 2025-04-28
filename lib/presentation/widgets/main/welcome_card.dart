import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pumba_ex/core/utilty/dates.dart';
import 'package:pumba_ex/data/models/user_model.dart';
import 'package:pumba_ex/presentation/bloc/notifications/notification_bloc.dart';
import 'package:pumba_ex/presentation/bloc/notifications/notification_state.dart';

class WelcomeCard extends StatelessWidget {
  final UserModel userModel;
  const WelcomeCard({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationBloc, NotificationState>(
      builder: (context, state) {
        final isScheduled = state is NotificationScheduled;
        final text = isScheduled
            ? 'Notification at ${Dates.formatTime(state.scheduledTime)}'
            : 'How are you today?';

        return Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          color: Colors.white.withOpacity(0.9),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Welcome, ${userModel.firstName } ${userModel.lastName }!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0A2472)),
                ),
                const SizedBox(height: 10),
                Text(
                  text,
                  style: TextStyle(fontSize: 16, color: Color(0xFF0A2472)),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}