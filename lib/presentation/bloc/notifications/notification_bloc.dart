import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pumba_ex/domain/usecases/notification_usecases.dart';
import 'package:pumba_ex/presentation/bloc/notifications/notification_event.dart';
import 'package:pumba_ex/presentation/bloc/notifications/notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final InitializeNotificationsUseCase initializeNotificationsUseCase;
  final CheckNotificationPermissionUseCase checkNotificationPermissionUseCase;
  final ScheduleNotificationUseCase scheduleNotificationUseCase;

  NotificationBloc({
    required this.initializeNotificationsUseCase,
    required this.checkNotificationPermissionUseCase,
    required this.scheduleNotificationUseCase,
  }) : super(NotificationInitial()) {
    on<RequestNotificationPermission>(_onRequestPermission);
    on<ScheduleNotification>(_onScheduleNotification);
  }

  Future<void> _onRequestPermission(
    RequestNotificationPermission event,
    Emitter<NotificationState> emit,
  ) async {
    try {
      await initializeNotificationsUseCase();
      final hasPermission = await checkNotificationPermissionUseCase();

      if (!hasPermission) {
        emit(NotificationError("Notification permissions are required"));
        return;
      }

      emit(NotificationPermissionGranted());
    } catch (e) {
      emit(NotificationError("Failed to request permissions: $e"));
    }
  }

  Future<void> _onScheduleNotification(
    ScheduleNotification event,
    Emitter<NotificationState> emit,
  ) async {
    try {
     

      DateTime scheduledTime = DateTime.now().add(Duration(minutes: 2));
      await scheduleNotificationUseCase(scheduledTime);
      emit(NotificationScheduled(scheduledTime));
    } catch (e) {
      emit(NotificationError("Failed to schedule notification: $e"));
    }
  }
}
