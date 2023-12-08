import 'package:bloc_practice_course/bloc_example1/extensions_and_enums.dart';
import 'package:flutter/material.dart';

@immutable 
abstract class LoadingAction{const LoadingAction();}

@immutable 
class LoadingPersonsAction extends LoadingAction{
  final PersonsUrl url;
  const LoadingPersonsAction({required this.url}): super();
}
