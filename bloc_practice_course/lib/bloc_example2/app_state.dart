import 'package:bloc_practice_course/bloc_example2/models.dart';
import 'package:flutter/material.dart';

@immutable 
class AppState{
  final bool isLoading; final LoginHandle? loginHandle; 
  final LoginErrors? loginError; final Iterable<Note>? notes;

  const AppState({required this.isLoading, required this.loginHandle, required this.loginError, required this.notes});
  const AppState.empty(): isLoading = false, loginHandle = null, loginError = null, notes = null;

  @override 
  String toString() => {
    'isLoading': isLoading, 'loginHandle': loginHandle,
    'loginError': loginError, 'notes': notes
  }.toString();
}