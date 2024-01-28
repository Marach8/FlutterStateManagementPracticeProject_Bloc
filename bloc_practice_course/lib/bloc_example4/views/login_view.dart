import 'package:bloc_practice_course/bloc_example4/bloc/app_bloc.dart';
import 'package:bloc_practice_course/bloc_example4/bloc/app_events.dart';
import 'package:bloc_practice_course/bloc_example4/extentions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LoginView extends HookWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController(
      text: 'emma@gmail.com'.ifDebugging
    );
    final passwordController = useTextEditingController(
      text: 'emmanuel'.ifDebugging
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('LogIn'), 
        centerTitle: true
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: 'Enter your email'
              ),
              keyboardType: TextInputType.emailAddress, 
              autocorrect: false,
              keyboardAppearance: Brightness.dark,
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                hintText: 'Enter your password'
              ),
              obscureText: true, 
              obscuringCharacter: '+', 
              autocorrect: false,
              keyboardAppearance: Brightness.dark,
            ),
            TextButton(
              onPressed: (){
                context.read<AppBloc4>().add(
                  LoginUserAppEvent(
                    email: emailController.text,
                    password: passwordController.text
                  )
                );
              },
              child: const Text('Log In')
            ),
            TextButton(
              onPressed: (){
                context.read<AppBloc4>().add(
                  const GoToRegistrationViewAppEvent()
                );
              },
              child: const Text('Not Registered? Register here.')
            )
          ]
        ),
      )
    );
  }
}