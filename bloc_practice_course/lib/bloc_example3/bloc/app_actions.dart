import 'package:flutter/material.dart';

@immutable 
abstract class AppAction3{
  const AppAction3();
}


@immutable 
class LoadNextUrlAction implements AppAction3{
  const LoadNextUrlAction();
}