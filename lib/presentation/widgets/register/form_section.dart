import 'package:flutter/material.dart';
import 'package:pumba_ex/presentation/widgets/general/custom_dropdowm.dart';
import 'package:pumba_ex/core/utilty/validation.dart';
import 'package:pumba_ex/presentation/widgets/general/custom_textfield.dart';

class InputFields extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;
  final String selectedGender;
  final Function(String) onGenderChanged;

  const InputFields({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
    required this.selectedGender,
    required this.onGenderChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        spacing: 15,
        children: [
          CustomTextField(
            controller: emailController,
            label: 'Email',
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: (value) => Validation.validateEmail(value ?? ''),
          ),
          CustomTextField(
            controller: passwordController,
            label: 'Password',
            icon: Icons.person_outline,
            validator: (value) => Validation.validateEmpty(value, 'Password'),
          ),
          Divider(
            thickness: 1,
            color: Colors.white.withOpacity(0.2),
          ),
          CustomTextField(
            controller: firstNameController,
            label: 'First Name',
            icon: Icons.person_outline,
            validator: (value) => Validation.validateEmpty(value, 'First Name'),
          ),
          CustomTextField(
            controller: lastNameController,
            label: 'Last Name',
            icon: Icons.person_outline,
            validator: (value) => Validation.validateEmpty(value, 'Last Name'),
          ),
          CustomDropdown(
            value: selectedGender,
            items: ['Male', 'Female'],
            onChanged: (value) {
              if (value != null) {
                onGenderChanged(value);
              }
            },
            labelText: 'Gender',
            prefixIcon: Icons.person,
          ),
        ],
      ),
    );
  }
}
