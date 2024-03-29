 import 'package:flutter/material.dart';

@immutable
class LoginHandle{
  final String token; 
  const  LoginHandle({required this.token});

  const LoginHandle.marach(): token = 'Nnanna Marach';

  @override 
  bool operator ==(covariant LoginHandle other) 
    => token == other.token;
  
  @override
  int get hashCode => token.hashCode;

  @override 
  String toString() => 'LoginHandle (token: $token)';
}


 enum LoginErrors{invalidHandle}


 @immutable 
 class Note{
  final String title; 
  const Note({required this.title});

  @override 
  String toString() => 'Note (title: $title)';
 }
