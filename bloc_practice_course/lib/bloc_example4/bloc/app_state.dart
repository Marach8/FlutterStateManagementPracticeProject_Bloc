import 'package:bloc_practice_course/bloc_example4/auth/auth_errors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

@immutable 
abstract class AppState{
  final bool isLoading; final AuthError? error;

  const AppState({required this.isLoading, required this.error});
}


@immutable 
class AppStateLoggedIn extends AppState{
  final User user; final Iterable<Reference> images;
  const AppStateLoggedIn({
    required bool isLoading, required AuthError? error,
    required this.images, required this.user
    }): super(isLoading: isLoading, error: error);

  @override 
  bool operator ==(other){
    if(other is AppStateLoggedIn){
      return isLoading == other.isLoading && user.uid == other.user.uid && 
      images.length == other.images.length;
    } else {return false;}
  }

  @override 
  int get hashCode => Object.hash(user.uid, images);

  @override 
  String toString() => 'AppStateLoggedIn: Images.length = ${images.length}';
}


@immutable 
class AppStateLoggedOut extends AppState{
  const AppStateLoggedOut({required bool isLoading, required AuthError? error})
  : super(isLoading: isLoading, error: error);

  @override 
  String toString() => 'AppStateLoggedOut: isLoading = $isLoading, error = $error';
}


@immutable 
class AppStateIsInRegistrationView extends AppState{
  const AppStateIsInRegistrationView({required bool isLoading, required AuthError? error})
    : super(error: error, isLoading: isLoading);
}