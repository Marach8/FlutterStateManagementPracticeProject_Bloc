import 'dart:io';
import 'package:bloc_practice_course/bloc_example4/bloc/app_events.dart';
import 'package:bloc_practice_course/bloc_example4/bloc/app_state.dart';
import 'package:bloc_practice_course/bloc_example4/extensions.dart';
import 'package:bloc_practice_course/bloc_example4/functions.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBloc4 extends Bloc<AppEvent, AppState4>{
  AppBloc4(): super(const AppStateLoggedOut(isLoading: false)){
    on<UploadImageAppEvent>((event, emit) async{
      final user = state.user;
      if(user == null){emit (const AppStateLoggedOut(isLoading: false)); return;}
      emit (AppStateLoggedIn(isLoading: true, images: state.images ?? [], user: user));
      final file = File(event.filePath);
      await uploadImage(file: file, userId: user.uid);
    });
  }

  Future<Iterable<Reference>> _getImages(String userId) 
    => FirebaseStorage.instance.ref(userId).list().then((result) => result.items);
}