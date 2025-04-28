abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationPermissionDenied extends NotificationState {}

class NotificationPermissionGranted extends NotificationState {}

class NotificationScheduled extends NotificationState {
  final DateTime scheduledTime;

  NotificationScheduled(this.scheduledTime);
}

class NotificationError extends NotificationState {
  final String message;

  NotificationError(this.message);
}