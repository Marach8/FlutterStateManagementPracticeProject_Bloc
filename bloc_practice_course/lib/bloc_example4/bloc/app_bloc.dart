import 'dart:io';
import 'package:bloc_practice_course/bloc_example4/auth/auth_errors.dart';
import 'package:bloc_practice_course/bloc_example4/bloc/app_events.dart';
import 'package:bloc_practice_course/bloc_example4/bloc/app_state.dart';
import 'package:bloc_practice_course/bloc_example4/extentions/extensions.dart';
import 'package:bloc_practice_course/bloc_example4/functions/functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBloc4 extends Bloc<AppEvent, AppState4>{
  AppBloc4(): super(
    const AppStateLoggedOut(isLoading: false)
  ){
    on<UploadImageAppEvent>((event, emit) async{
      final user = state.user;
      if(user == null){
        emit (
          const AppStateLoggedOut(isLoading: false)
        )
        ; return;
      }
      emit (AppStateLoggedIn(isLoading: true, images: state.images ?? [], user: user));
      final file = File(event.filePath);
      await uploadImage(file: file, userId: user.uid);
      final retrievedImages = await getImages(user.uid);
      emit (AppStateLoggedIn(images: retrievedImages, isLoading: false,user: user));
    });

    on<DeleteAccountAppEvent> ((event, emit) async{
      final user = FirebaseAuth.instance.currentUser;
      if(user == null){emit (const AppStateLoggedOut(isLoading: false)); return;}
      emit (AppStateLoggedIn(isLoading: true, images: state.images ?? [], user: user));
      try{
        await FirebaseStorage.instance.ref(user.uid).delete().catchError((_){});
        await user.delete();
        await FirebaseAuth.instance.signOut();
        emit (const AppStateLoggedOut(isLoading:false));
      } on FirebaseAuthException catch(e){
        emit (AppStateLoggedIn(
          isLoading: false, images: state.images ?? [], 
          user: user, error: AuthError.from(e)
        ));
      } on FirebaseException{
        emit (const AppStateLoggedOut(isLoading:false));
      }
    });

    on<LogoutUserAppEvent> ((event, emit) async{
      emit (const AppStateLoggedOut(isLoading: true));
      await FirebaseAuth.instance.signOut();
      emit (const AppStateLoggedOut(isLoading:false));
    });

    on<InitializationAppEvent>((event, emit) async{
      final user = FirebaseAuth.instance.currentUser;
      if(user == null){emit (const AppStateLoggedOut(isLoading: false)); return;}
      final userImages = await getImages(user.uid);
      emit(AppStateLoggedIn(images: userImages, isLoading: false, user: user));
    });

    on<RegisterUserAppEvent> ((event, emit) async{
      emit(const AppStateIsInRegistrationView(isLoading: true));
      if (event.email.isNotEmpty && event.password.isNotEmpty){
        try{
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: event.email, password: event.password
          );
          emit(const AppStateLoggedOut(isLoading: false));
        } on FirebaseAuthException catch(e){
          emit(AppStateIsInRegistrationView(isLoading: false, error: AuthError.from(e)));
        }
      }
    });

    on<LoginUserAppEvent> ((event, emit) async{
      emit(const AppStateLoggedOut(isLoading: true));
      try{
        final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: event.email, password: event.password
        );
        final userImages = await getImages(userCredential.user!.uid);
        emit(AppStateLoggedIn(isLoading: false, images: userImages, user: userCredential.user!));
      } on FirebaseAuthException catch (e){
        emit(AppStateLoggedOut(isLoading: false, error: AuthError.from(e)));
      }
    });

    on<GoToLoginViewAppEvent>((event, emit){
      emit(const AppStateLoggedOut(isLoading: false));
    });

    on<GoToRegistrationViewAppEvent> ((event, emit){
      emit (const AppStateIsInRegistrationView(isLoading: false));
    });
  }
}