import 'package:bloc_practice_course/bloc_example2/api/login_api.dart';
import 'package:bloc_practice_course/bloc_example2/api/notes_api.dart';
import 'package:bloc_practice_course/bloc_example2/bloc/app_bloc.dart';
import 'package:bloc_practice_course/bloc_example2/bloc/app_state.dart';
import 'package:bloc_practice_course/bloc_example2/custom_widgets/generic_dialog.dart';
import 'package:bloc_practice_course/bloc_example2/loadscreen/loading_screen.dart';
import 'package:bloc_practice_course/bloc_example2/others/actions.dart';
import 'package:bloc_practice_course/bloc_example2/others/extensions.dart';
import 'package:bloc_practice_course/bloc_example2/others/models.dart';
import 'package:bloc_practice_course/bloc_example2/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocExample2 extends StatelessWidget {
  const BlocExample2({super.key});

  @override
  Widget build(BuildContext context) {
    final loadingScreen = LoadingScreen();
    return BlocProvider(
      create: (_) => AppBloc(
        loginApi: LoginApi(), 
        notesApi: NotesApi(),
        acceptableLoginHandle: const LoginHandle.marach()
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Bloc2 Example'), 
          centerTitle: true
        ),
        body: BlocConsumer<AppBloc, AppState>(
          listener: (context, appState){
            if (appState.isLoading){
              loadingScreen.showOverlay(
                context: context, text: 'PleaseWait'
              );
            }
            else{
              loadingScreen.hideOverlay();
            }
            final loginError = appState.loginError;
            if(loginError != null){
              showGenericDialog(
                context: context, 
                title: 'LoginError', 
                content: 'An Error Occured During Login', 
                optionsBuilder: () => {'ok': true}
              );
            }
            if(
              appState.isLoading == false 
              && appState.loginError == null
              && appState.loginHandle == const LoginHandle.marach() 
              && appState.notes == null
            ){
              context.read<AppBloc>().add(
                const LoadNotesAction()
              );
            }
          },
          builder: (context, appState){
            final notes = appState.notes;
            if(notes == null){
              return LoginView(
                loginTapped: (email, password){
                  context.read<AppBloc>().add(
                    LoginAction(email: email, password: password)
                  );
                }
              );
            }
            else{
              return notes.toListView();
            }
          }
        )
      ),
    );
  }
}