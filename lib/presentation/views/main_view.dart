import 'package:flutter/material.dart';
import 'package:pumba_ex/core/router/app_router.dart';
import 'package:pumba_ex/core/router/routes.dart';
import 'package:pumba_ex/data/models/user_model.dart';
import 'package:pumba_ex/presentation/bloc/auth/auth_state.dart';
import 'package:pumba_ex/presentation/widgets/general/lifesycle_ovserver.dart';
import 'package:pumba_ex/presentation/widgets/main/location_card.dart';
import 'package:pumba_ex/presentation/widgets/main/start_bttb.dart';
import 'package:pumba_ex/presentation/widgets/main/welcome_card.dart';
import 'package:pumba_ex/presentation/widgets/general/header_section.dart';
import 'package:pumba_ex/presentation/widgets/general/custom_bttn.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pumba_ex/presentation/bloc/auth/auth_bloc.dart';
import 'package:pumba_ex/presentation/bloc/auth/auth_event.dart';

class MainView extends StatelessWidget {
  final UserModel userModel;
  const MainView({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    return LifecycleObserver(
      userId: userModel.id!,
      child: Scaffold(
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is Unauthenticated) {
              AppRouter.navigateTo(context, Routes.registerRoute);
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF3A86FF), Color(0xFF0A2472)],
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  spacing: 30,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    HeaderSection(title: 'Home'),
                    WelcomeCard(userModel: userModel),
                    LocationCard(),
                    StartBttn(),
                    Spacer(),
                    CustomButton(
                      onPressed: () => context
                          .read<AuthBloc>()
                          .add(DeleteAccount(userId: userModel.id ?? '')),
                      iconData: Icons.delete,
                      text: 'Delete account',
                      textColor: Colors.white,
                      backgroundColor: Colors.red,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
