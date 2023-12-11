import 'package:bloc_practice_course/bloc_example2/custom_widgets/text_buttons.dart';
import 'package:bloc_practice_course/bloc_example2/custom_widgets/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LoginView extends HookWidget {
  final OnLoginTapped loginTapped;
  const LoginView({required this.loginTapped, super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    return Column(
      children: [
        EmailField(emailController: emailController),
        PasswordField(passwordController: passwordController),
        LoginButton(
          emailController: emailController, passwordController: passwordController, 
          loginTapped: loginTapped
        )
      ]
    );
  }
}

