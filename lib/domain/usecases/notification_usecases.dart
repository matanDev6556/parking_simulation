
import 'package:pumba_ex/domain/repositories/i_notification_repository.dart';

class InitializeNotificationsUseCase {
  final INotificationRepository notificationRepository;

  InitializeNotificationsUseCase({required this.notificationRepository});

  Future<void> call() async {
    await notificationRepository.initialize();
  }
}

class CheckNotificationPermissionUseCase {
  final INotificationRepository notificationRepository;

  CheckNotificationPermissionUseCase({required this.notificationRepository});

  Future<bool> call() async {
    return await notificationRepository.checkAndRequestPermission();
  }
}

class ScheduleNotificationUseCase {
  final INotificationRepository notificationRepository;

  ScheduleNotificationUseCase({required this.notificationRepository});

  Future<void> call(DateTime scheduleTime) async {
    await notificationRepository.scheduleNotification(scheduleTime);
  }
}

