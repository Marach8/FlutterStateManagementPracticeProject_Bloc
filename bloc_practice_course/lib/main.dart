import 'package:bloc_practice_course/bloc_example1/customclasses.dart';
import 'package:bloc_practice_course/bloc_example1/homepage.dart';
import 'package:bloc_practice_course/bloc_example2/actions.dart';
import 'package:bloc_practice_course/bloc_example2/app_bloc.dart';
import 'package:bloc_practice_course/bloc_example2/app_state.dart';
import 'package:bloc_practice_course/bloc_example2/extensions.dart';
import 'package:bloc_practice_course/bloc_example2/generic_dialog.dart';
import 'package:bloc_practice_course/bloc_example2/loading_screen.dart';
import 'package:bloc_practice_course/bloc_example2/login_api.dart';
import 'package:bloc_practice_course/bloc_example2/models.dart';
import 'package:bloc_practice_course/bloc_example2/notes_api.dart';
import 'package:bloc_practice_course/bloc_example2/views/login_view.dart';
import 'package:bloc_practice_course/cubit_example/cubit_example.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(backgroundColor: Colors.blue),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (_) => PersonBloc(), child: const BlocExample1()
      ),
    );
  }
}


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppBloc(
        loginApi: LoginApi(), notesApi: NotesApi()
      ),
      child: Scaffold(
        appBar: AppBar(title: const Text('Bloc2 Example'), centerTitle: true),
        body: BlocConsumer<AppBloc, AppState>(
          listener: (context, appState){
            if (appState.isLoading){LoadingScreen().showOverlay(context: context, text: 'PleaseWait');}
            else{LoadingScreen().hideOverlay();}
            final loginError = appState.loginError;
            if(loginError != null){
              showGenericDialog(
                context: context, title: 'LoginError', content: 'An Error Occured During Login', 
                optionsBuilder: () => {'ok': true}
              );
            }
            if(
              appState.isLoading == false && appState.loginError == null
              && appState.loginHandle == const LoginHandle.marach() && appState.notes == null
            ){context.read<AppBloc>().add(const LoadNotesAction());}
          },
          builder: (context, appState){
            final notes = appState.notes;
            if(notes == null){return LoginView(loginTapped: (email, password){},);}
            else{return notes.toListView();}
          }
        )
      ),
    );
  }
}