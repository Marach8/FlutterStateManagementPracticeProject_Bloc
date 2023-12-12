import 'package:bloc_practice_course/bloc_example3/bloc/app_actions.dart';
import 'package:bloc_practice_course/bloc_example3/bloc/app_state.dart';
import 'package:bloc_practice_course/bloc_example3/others/extension.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


typedef RandomImageUrlPicker = String Function(Iterable<String> allUrls);

class AppBloc3 extends Bloc<AppAction3, AppState3>{

  String _pickRandomUrl(Iterable<String> allUrls) => allUrls.getRandomElement();

  AppBloc3({
    RandomImageUrlPicker? urlPicker, required Iterable<String> urls, Duration? waitBeforeLoading
  }): super(const AppState3.empty()){
    on<LoadNextUrlAction> ((event, emit) async{
      //Start Loading
      emit(const AppState3(isLoading: true, data: null, error: null));
      final url = (urlPicker ?? _pickRandomUrl)(urls);
      try{
        if (waitBeforeLoading != null){Future.delayed(waitBeforeLoading);}
        final bundle = NetworkAssetBundle(Uri.parse(url));
        final data = (await bundle.load(url)).buffer.asUint8List();
        emit(AppState3(isLoading: false, data: data, error: null));
      } catch(e){
        emit(AppState3(isLoading: false, data: null, error: e));
      }
    });
  }
}



class BlocOne extends AppBloc3{
  BlocOne({Duration? waitBeforeLoading, required Iterable<String> urls})
    : super(urls: urls, waitBeforeLoading: waitBeforeLoading);
}


class BlocTwo extends AppBloc3{
  BlocTwo({Duration? waitBeforeLoading, required Iterable<String> urls})
    : super(urls: urls, waitBeforeLoading: waitBeforeLoading);
}