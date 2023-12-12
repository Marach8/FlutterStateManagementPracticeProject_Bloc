import 'dart:typed_data';

import 'package:flutter/material.dart';

@immutable 
class AppState3{
  final bool isLoading; final Uint8List? data; final Object? error;

  const AppState3({required this.isLoading, required this.data, required this.error});
  const AppState3.empty(): isLoading = false, data = null, error = null;

  @override
  String toString() => {'isLoading': isLoading, 'data': data != null, 'error': error}.toString();
}