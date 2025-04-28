import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:pumba_ex/data/models/user_model.dart';
import 'package:pumba_ex/data/repositories/app_lifecycle_repository.dart';
import 'package:pumba_ex/data/repositories/location_repository.dart';
import 'package:pumba_ex/data/repositories/notification_repository.dart';
import 'package:pumba_ex/data/services/app_lifecycle_service.dart';
import 'package:pumba_ex/domain/repositories/i_app_lifecycle_repository.dart';
import 'package:pumba_ex/domain/repositories/i_auth_repository.dart';
import 'package:pumba_ex/domain/repositories/i_location_repository.dart';
import 'package:pumba_ex/domain/repositories/i_notification_repository.dart';
import 'package:pumba_ex/domain/repositories/i_user_repository.dart';
import 'package:pumba_ex/domain/usecases/app_lifesycle_uscecases.dart';
import 'package:pumba_ex/domain/usecases/auth_usecases.dart';
import 'package:pumba_ex/domain/usecases/location_usecases.dart';
import 'package:pumba_ex/domain/usecases/notification_usecases.dart';
import 'package:pumba_ex/presentation/bloc/auth/auth_bloc.dart';
import 'package:pumba_ex/presentation/bloc/lifecycle/lifesycle_cubit.dart';
import 'package:pumba_ex/presentation/bloc/location/location_cubit.dart';
import 'package:pumba_ex/presentation/bloc/notifications/notification_bloc.dart';
import 'package:pumba_ex/data/repositories/auth_repository.dart';
import 'package:pumba_ex/data/repositories/user_repository.dart';
import 'package:pumba_ex/data/services/auth_service.dart';
import 'package:pumba_ex/data/services/firebase_service.dart';
import 'package:pumba_ex/data/services/location_servic.dart';
import 'package:pumba_ex/data/services/notifications_service.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  // app lifesycle
  initializeLifecycleDependencies();
  //user
  initializeUserDependencies();
  // notification
  initializeNotificationDependencies();
  //auth
  initaillizeAuthDependencies();
  // location
  initializeLocationDependencies();

  print('di initialization completed');
}

void initializeUserDependencies() {
  // Services
  getIt.registerLazySingleton(() => FirebaseService());

  //repository
  getIt.registerLazySingleton<IUserRepository>(
    () => UserRepository(firebaseService: getIt()),
  );

  // usecases
}

void initializeNotificationDependencies() {
  // Services
  getIt.registerSingleton<NotificationService>(NotificationService());

  // Repositories
  getIt.registerSingleton<INotificationRepository>(
    NotificationRepository(notificationService: getIt()),
  );

  // Use Cases
  getIt.registerSingleton<InitializeNotificationsUseCase>(
    InitializeNotificationsUseCase(notificationRepository: getIt()),
  );

  getIt.registerSingleton<CheckNotificationPermissionUseCase>(
    CheckNotificationPermissionUseCase(notificationRepository: getIt()),
  );

  getIt.registerSingleton<ScheduleNotificationUseCase>(
    ScheduleNotificationUseCase(notificationRepository: getIt()),
  );

  // Bloc
  getIt.registerFactory<NotificationBloc>(
    () => NotificationBloc(
      initializeNotificationsUseCase: getIt(),
      checkNotificationPermissionUseCase: getIt(),
      scheduleNotificationUseCase: getIt(),
    ),
  );
}

void initializeLocationDependencies() {
  // Services
  getIt.registerSingleton<LocationService>(LocationService());

  // Repositories
  getIt.registerSingleton<ILocationRepository>(
    LocationRepository(locationService: getIt()),
  );

  // Use Cases
  getIt.registerSingleton<CheckLocationPermissionUseCase>(
    CheckLocationPermissionUseCase(locationRepository: getIt()),
  );

  getIt.registerSingleton<RequestLocationPermissionUseCase>(
    RequestLocationPermissionUseCase(locationRepository: getIt()),
  );

  getIt.registerSingleton<GetCurrentLocationUseCase>(
    GetCurrentLocationUseCase(locationRepository: getIt()),
  );

  // Cubit
  getIt.registerFactory<LocationCubit>(
    () => LocationCubit(
      checkLocationPermissionUseCase: getIt(),
      requestLocationPermissionUseCase: getIt(),
      getCurrentLocationUseCase: getIt(),
    ),
  );
}

void initaillizeAuthDependencies() {
  //Service
  getIt.registerLazySingleton(() => AuthService());

  // Repositories
  getIt.registerLazySingleton<IAuthRepository<UserModel>>(
    () => AuthRepository(authService: getIt()),
  );

  // Use Cases
  getIt.registerSingleton<CheckAuthStatusUseCase>(
    CheckAuthStatusUseCase(
      authRepository: getIt(),
      userRepository: getIt(),
    ),
  );

  getIt.registerSingleton<SignUpUserUseCase>(
    SignUpUserUseCase(
      authRepository: getIt(),
      userRepository: getIt(),
    ),
  );

  getIt.registerSingleton<DeleteAccountUseCase>(
    DeleteAccountUseCase(
      authRepository: getIt(),
      userRepository: getIt(),
    ),
  );

  getIt.registerSingleton<LogoutUserUseCase>(
    LogoutUserUseCase(authRepository: getIt()),
  );

  // Blocs
  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(
      checkAuthStatusUseCase: getIt(),
      signUpUserUseCase: getIt(),
      deleteAccountUseCase: getIt(),
      logoutUserUseCase: getIt(),
    ),
  );
}

void initializeLifecycleDependencies() {
  // Services
  getIt.registerSingleton<AppLifecycleService>(
    AppLifecycleService(FirebaseFirestore.instance),
  );

  // Repositories
  getIt.registerSingleton<IAppLifecycleRepository>(
    AppLifecycleRepository(getIt()),
  );

  // Use Cases
  getIt.registerSingleton<MonitorAppLifecycleUseCase>(
    MonitorAppLifecycleUseCase(getIt()),
  );

  // Cubit
  getIt.registerFactory<LifecycleCubit>(
    () => LifecycleCubit(getIt()),
  );
}
