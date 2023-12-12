import 'dart:math' as math;

import 'package:bloc_practice_course/bloc_example3/app_actions.dart';
import 'package:bloc_practice_course/bloc_example3/app_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


typedef RandomImageUrlPicker = String Function(Iterable<String> allUrls);

extension RandomElement<T> on Iterable<T> {
  T getElement() => elementAt(math.Random().nextInt(length));
}

class AppBloc3 extends Bloc<AppAction3, AppState3>{
  AppBloc3(): super(const AppState3.empty()){

  }
}