import 'dart:typed_data';
import 'package:bloc_practice_course/bloc_example3/bloc/app_actions.dart';
import 'package:bloc_practice_course/bloc_example3/bloc/app_bloc.dart';
import 'package:bloc_practice_course/bloc_example3/bloc/app_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';


extension ToList on String{Uint8List toUint8List() => Uint8List.fromList(codeUnits);}

final data1 = 'Marach'.toUint8List();
final data2 = 'Emmanuel'.toUint8List();

enum Errors{marach}

void main(){
  blocTest(
    'Initial State of the block should be empty',
    build: () => AppBloc3(urls: [],),
    verify: (appBloc3) => expect(appBloc3.state, const AppState3.empty())
  );

  blocTest(
    'Check if we are able to load url data',
    build: () => AppBloc3(urls: [], urlPicker: (_) => '', urlLoader: (_) => Future.value(data1)),
    act: (appBloc) => appBloc.add(const LoadNextUrlAction()),
    expect: () => [
      const AppState3(isLoading: true, data: null, error: null),
      AppState3(isLoading: false, data: data1, error: null)
    ]
  );
  
  blocTest(
    'Check if we are able to throw error',
    build: () => AppBloc3(urls: [], urlPicker: (_) => '', urlLoader: (_) => Future.error(Errors.marach)),
    act: (appBloc) => appBloc.add(const LoadNextUrlAction()),
    expect: () => [
      const AppState3(isLoading: true, data: null, error: null),
      const AppState3(isLoading: false, data: null, error: Errors.marach)
    ]
  );

  blocTest(
    'Check if we are able to load more than one url data',
    build: () => AppBloc3(urls: [], urlPicker: (_) => '', urlLoader: (_) => Future.value(data2)),
    act: (appBloc) {appBloc.add(const LoadNextUrlAction()); appBloc.add(const LoadNextUrlAction());},
    expect: () => [
      const AppState3(isLoading: true, data: null, error: null),
      AppState3(isLoading: false, data: data2, error: null),
      const AppState3(isLoading: true, data: null, error: null),
      AppState3(isLoading: false, data: data2, error: null)
    ]
  );
}