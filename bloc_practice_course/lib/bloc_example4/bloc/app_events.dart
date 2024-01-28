import 'package:flutter/material.dart';

@immutable 
abstract class AppEvent{
  const AppEvent();
}


@immutable 
class UploadImageAppEvent implements AppEvent{
  final String filePath;

  const UploadImageAppEvent({
    required this.filePath
  });
}

@immutable 
class DeleteAccountAppEvent implements AppEvent{
  const DeleteAccountAppEvent();
}

@immutable 
class LogoutUserAppEvent implements AppEvent{
  const LogoutUserAppEvent();
}

@immutable 
class InitializationAppEvent implements AppEvent{
  const InitializationAppEvent();
}

@immutable 
class LoginUserAppEvent implements AppEvent{
  final String email, password;

  const LoginUserAppEvent({
    required this.email, 
    required this.password
  });
}

@immutable 
class GoToRegistrationViewAppEvent implements AppEvent{
  const GoToRegistrationViewAppEvent();
}

@immutable 
class GoToLoginViewAppEvent implements AppEvent{
  const GoToLoginViewAppEvent();
}

@immutable 
class RegisterUserAppEvent implements AppEvent{
  final String email, password;
  
  const RegisterUserAppEvent({
    required this.email, 
    required this.password
  });
}