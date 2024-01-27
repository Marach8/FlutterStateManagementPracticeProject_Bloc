import 'package:bloc_practice_course/bloc_example2/others/models.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

@immutable 
class AppState{
  final bool isLoading; 
  final LoginHandle? loginHandle; 
  final LoginErrors? loginError; 
  final Iterable<Note>? notes;

  const AppState({
    required this.isLoading, 
    required this.loginHandle, 
    required this.loginError, 
    required this.notes
  });

  const AppState.empty()
    : isLoading = false, 
      loginHandle = null, 
      loginError = null, 
      notes = null;

  @override 
  String toString() => {
    'isLoading': isLoading, 
    'loginHandle': loginHandle,
    'loginError': loginError, 
    'notes': notes
  }.toString();
  
  @override 
  bool operator ==(covariant AppState other){
    final otherPropertiesAreEqual = isLoading == other.isLoading 
      && loginHandle == other.loginHandle 
      && loginError == other.loginError;

    if(notes == null && other.notes == null){
      return otherPropertiesAreEqual;
    }
    else{
      return otherPropertiesAreEqual
      && (notes?.isEqualTo(other.notes) ?? false);
    }
  }
  
  @override
  int get hashCode => Object.hash(
    isLoading, 
    loginError, 
    loginHandle, 
    notes
  );
}



extension UnorderedEquality on Object{
  bool isEqualTo(other)
   => const DeepCollectionEquality
    .unordered()
    .equals(this, other);
}