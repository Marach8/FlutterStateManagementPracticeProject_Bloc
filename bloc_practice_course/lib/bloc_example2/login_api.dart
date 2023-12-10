import 'package:bloc_practice_course/bloc_example2/models.dart';
import 'package:flutter/material.dart';

@immutable 
abstract class LoginApiProtocol{
  const LoginApiProtocol();
  
  Future<LoginHandle?> login({required String email, required String password});
}


@immutable
class LoginApi implements LoginApiProtocol{
  const LoginApi._sharedInstance();
  static const LoginApi _shared = LoginApi._sharedInstance();
  factory LoginApi() => _shared;

  @override
  Future<LoginHandle?> login({required String email, required String password})
    => Future.delayed(const Duration(seconds: 2), () => email == 'emma@gmail.com' && password == 'emmanuel')
    .then((isLoggedIn) => isLoggedIn? const LoginHandle.marach(): null);
}