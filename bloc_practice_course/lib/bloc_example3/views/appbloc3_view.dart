import 'package:bloc_practice_course/bloc_example3/bloc/app_actions.dart';
import 'package:bloc_practice_course/bloc_example3/bloc/app_bloc.dart';
import 'package:bloc_practice_course/bloc_example3/bloc/app_state.dart';
import 'package:bloc_practice_course/bloc_example3/others/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBloc3View<T extends AppBloc3> extends StatelessWidget{
  const AppBloc3View({super.key});

  void startUpdatingBloc(BuildContext context){
    Stream.periodic(const Duration(seconds: 10), 
      (_) => const LoadNextUrlAction()).startWith(const LoadNextUrlAction())
        .forEach((event) {context.read<T> ().add(event);});
  }

  @override
  Widget build(BuildContext context) {
    startUpdatingBloc(context);
    return Expanded(
      child: BlocBuilder<T, AppState3>(
        builder: (context, appState){
          if(appState.error != null){return const Center(child: Text('An Error Occured!'));}
          else if(appState.data != null){return Container(color: Colors.red, child: Image.memory(appState.data!, fit: BoxFit.cover));}
          else{return const Center(child: CircularProgressIndicator());}
        }
      ),
    );
  }

}