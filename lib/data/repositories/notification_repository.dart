import 'package:pumba_ex/data/services/notifications_service.dart';
import 'package:pumba_ex/domain/repositories/i_notification_repository.dart';

class NotificationRepository implements INotificationRepository {
  final NotificationService _notificationService;

  NotificationRepository({required NotificationService notificationService})
      : _notificationService = notificationService;

  @override
  Future<void> initialize() async {
    await _notificationService.initialize();
  }

  @override
  Future<bool> checkAndRequestPermission() async {
    return await _notificationService.checkAndRequestNotificationPermission();
  }

  @override
  Future<void> scheduleNotification(DateTime scheduleTime) async {
    await _notificationService.scheduleNotification(scheduleTime);
  }
}
