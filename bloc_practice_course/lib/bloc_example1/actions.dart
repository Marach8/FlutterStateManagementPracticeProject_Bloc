import 'package:bloc_practice_course/bloc_example1/functions.dart';
import 'package:flutter/material.dart';

@immutable 
abstract class LoadingAction{const LoadingAction();}

@immutable 
class LoadingPersonsAction extends LoadingAction{
  final String url; final PersonsLoader loader;
  const LoadingPersonsAction({required this.url, required this.loader}): super();
}
