import 'package:bloc_practice_course/bloc_example2/loadscreen/loading_screen.dart';
import 'package:bloc_practice_course/bloc_example4/bloc/app_bloc.dart';
import 'package:bloc_practice_course/bloc_example4/bloc/app_events.dart';
import 'package:bloc_practice_course/bloc_example4/bloc/app_state.dart';
import 'package:bloc_practice_course/bloc_example4/dialogs/dialogs.dart';
import 'package:bloc_practice_course/bloc_example4/views/login_view.dart';
import 'package:bloc_practice_course/bloc_example4/views/photo_gallery_view.dart';
import 'package:bloc_practice_course/bloc_example4/views/register_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBloc4>(
      create: (_) => AppBloc4()..add(const InitializationAppEvent()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(backgroundColor: Colors.blue),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: BlocConsumer<AppBloc4, AppState4>(
          listener: (context, appState){
            if (appState.isLoading){
              LoadingScreen().showOverlay(context: context, text: 'Loading...');
            }
            else{LoadingScreen().hideOverlay();}

            final authError = appState.error;
            if(authError != null){authErrorDialog(context: context, error: authError);}
          },

          builder: (context, appState){
            if (appState is AppStateLoggedIn){return const PhotoGalleryView();}
            else if (appState is AppStateLoggedOut){return const LoginView();}
            else if (appState is AppStateIsInRegistrationView){return const RegisterView();}
            else{return Container();}
          }
        )
      ),
    );
  }
}