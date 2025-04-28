import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pumba_ex/core/router/app_router.dart';
import 'package:pumba_ex/core/router/routes.dart';
import 'package:pumba_ex/presentation/bloc/auth/auth_bloc.dart';
import 'package:pumba_ex/presentation/bloc/auth/auth_event.dart';
import 'package:pumba_ex/presentation/bloc/auth/auth_state.dart';
import 'package:pumba_ex/presentation/widgets/general/custom_bttn.dart';
import 'package:pumba_ex/data/models/user_model.dart';
import 'package:pumba_ex/presentation/widgets/register/footer_section.dart';
import 'package:pumba_ex/presentation/widgets/register/form_section.dart';
import 'package:pumba_ex/presentation/widgets/general/header_section.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({super.key});

  @override
  _RegistrationViewState createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _selectedGender = 'Male';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is Authenticated) {
          AppRouter.navigateTo(context, Routes.mainRoute,
              arguments: state.user);
        }
      },
      builder: (context, state) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarColor: Color(0xFF3A86FF),
            statusBarIconBrightness: Brightness.light,
          ),
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: SafeArea(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF3A86FF), Color(0xFF0A2472)],
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 25),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              HeaderSection(title: 'Register'),
                              SizedBox(height: 30),
                              InputFields(
                                firstNameController: _firstNameController,
                                lastNameController: _lastNameController,
                                emailController: _emailController,
                                passwordController: _passwordController,
                                formKey: _formKey,
                                selectedGender: _selectedGender,
                                onGenderChanged: (value) {
                                  setState(() {
                                    _selectedGender = value;
                                  });
                                },
                              ),
                              SizedBox(height: 30),
                              CustomButton(
                                width: double.infinity,
                                text: state is AuthLoading
                                    ? 'Loading...'
                                    : 'Register',
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    final user = UserModel(
                                      firstName: _firstNameController.text,
                                      lastName: _lastNameController.text,
                                      email: _emailController.text,
                                      gender: _selectedGender,
                                    );
                                    context.read<AuthBloc>().add(SignUpUser(
                                          password: _passwordController.text,
                                          userModel: user,
                                        ));
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    FooterSection(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
