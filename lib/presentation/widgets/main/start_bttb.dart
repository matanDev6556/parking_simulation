import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pumba_ex/presentation/bloc/notifications/notification_bloc.dart';
import 'package:pumba_ex/presentation/bloc/notifications/notification_event.dart';
import 'package:pumba_ex/presentation/bloc/notifications/notification_state.dart';
import 'package:pumba_ex/presentation/widgets/general/custom_bttn.dart';

class StartBttn extends StatelessWidget {
  const StartBttn({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationBloc, NotificationState>(
      listener: (context, state) {
        if (state is NotificationError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        final isScheduled = state is NotificationScheduled;

        return Visibility(
          visible: !isScheduled,
          child: CustomButton(
            iconData: Icons.notifications_active,
            onPressed: () =>
                context.read<NotificationBloc>().add(ScheduleNotification()),
            text: 'Start parking',
          ),
        );
      },
    );
  }
}
