import 'dart:typed_data';

import 'package:bloc_practice_course/bloc_example3/others/extension.dart';
import 'package:flutter/material.dart';

@immutable 
class AppState3{
  final bool isLoading; 
  final Uint8List? data; 
  final Object? error;

  const AppState3({
    required this.isLoading, 
    required this.data, 
    required this.error
  });

  const AppState3.empty()
    : isLoading = false, 
      data = null, 
      error = null;

  @override
  String toString() => {
    'isLoading': isLoading, 
    'data': data != null, 
    'error': error
  }.toString();

  @override 
  bool operator ==(covariant AppState3 other)
    => isLoading == other.isLoading 
    && error == other.error 
    && (data ?? []).isEqualTo(other.data ?? []);
    
  @override 
  int get hashCode => Object.hash(
    isLoading, data, error
  );
}