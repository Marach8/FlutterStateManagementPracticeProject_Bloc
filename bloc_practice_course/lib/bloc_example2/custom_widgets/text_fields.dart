import 'package:flutter/material.dart';

class EmailField extends StatelessWidget{
  final TextEditingController emailController;

  const EmailField({
    required this.emailController, 
    super.key
  });
  
  @override
  Widget build(BuildContext context) => TextField(
    controller: emailController, 
    keyboardType: TextInputType.emailAddress,
    autocorrect: true,
    decoration: const InputDecoration(
      hintText: 'Enter your email here.'
    )
  );
}


class PasswordField extends StatelessWidget{
  final TextEditingController passwordController;
  const PasswordField({required this.passwordController, super.key});

  @override 
  Widget build(BuildContext context) => TextField(
    controller: passwordController, 
    autocorrect: true, 
    obscureText: true,
    decoration: const InputDecoration(
      hintText: 'Enter your password here.'
    ),
    obscuringCharacter: '*'
  );
}