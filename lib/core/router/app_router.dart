import 'package:flutter/material.dart';
import 'package:pumba_ex/core/router/routes.dart';
import 'package:pumba_ex/data/models/user_model.dart';
import 'package:pumba_ex/presentation/views/main_view.dart';
import 'package:pumba_ex/presentation/views/register_view.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.registerRoute:
        return MaterialPageRoute(
          builder: (_) => RegistrationView(),
        );
      
      case Routes.mainRoute:
        final userModel = settings.arguments as UserModel;
        return MaterialPageRoute(
          builder: (_) => MainView(userModel: userModel),
        );
        
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }

   static void navigateTo(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    Navigator.of(context).pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  static void navigateReplacement(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    Navigator.of(context).pushReplacementNamed(
      routeName,
      arguments: arguments,
    );
  }

  static void navigateBack(BuildContext context) {
    Navigator.of(context).pop();
  }
}