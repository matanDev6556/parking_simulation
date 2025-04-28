abstract class INotificationRepository {
  Future<void> initialize();
  Future<bool> checkAndRequestPermission();
  Future<void> scheduleNotification(DateTime scheduleTime);
 
}