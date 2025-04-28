import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pumba_ex/core/router/app_router.dart';
import 'package:pumba_ex/presentation/bloc/auth/auth_bloc.dart';
import 'package:pumba_ex/presentation/bloc/auth/auth_event.dart';
import 'package:pumba_ex/presentation/bloc/lifecycle/lifesycle_cubit.dart';
import 'package:pumba_ex/presentation/bloc/location/location_cubit.dart';
import 'package:pumba_ex/presentation/bloc/notifications/notification_bloc.dart';
import 'package:pumba_ex/presentation/bloc/notifications/notification_event.dart';
import 'package:pumba_ex/core/di/injection_container.dart';
import 'package:pumba_ex/core/utilty/app_style.dart';
import 'package:pumba_ex/presentation/views/register_view.dart';
import 'package:timezone/data/latest_all.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // init firebase
  await initializeDependencies(); // init dependencies
  tz.initializeTimeZones(); // init times zone
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<LifecycleCubit>(),
        ),
        BlocProvider(
            create: (context) => getIt<AuthBloc>()..add(CheckAuthStatus())),
        BlocProvider(
            create: (context) => getIt<NotificationBloc>()
              ..add(RequestNotificationPermission())),
        BlocProvider(create: (context) => getIt<LocationCubit>()),
      ],
      child: MaterialApp(
        title: 'Pumba assignment',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppStyle.classicBlue),
          useMaterial3: true,
        ),
        home: RegistrationView(),
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
