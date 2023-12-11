import 'package:bloc_practice_course/bloc_example2/custom_widgets/generic_dialog.dart';
import 'package:flutter/material.dart';

typedef OnLoginTapped = void Function(String email, String password);

class LoginButton extends StatelessWidget{
  final TextEditingController emailController, passwordController;
  final OnLoginTapped loginTapped;
  const LoginButton({
    super.key, required this.emailController,
    required this.passwordController, required this.loginTapped
  });
  
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (){
        final email = emailController.text; final password = passwordController.text;
        if(email.isEmpty || password.isEmpty){
          showGenericDialog(
            context: context, title: 'Invalid Email or Password Field',
            content: 'Either your Email or Password Field is empty!',
            optionsBuilder: () => {'OK': true}
          );
        } else {
          loginTapped(email, password);
        }
      }, 
      child: const Text('Login')
    );
  }
}