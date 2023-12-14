import 'package:bloc_practice_course/bloc_example4/bloc/app_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

extension GetUser on AppState4{
  User? get user {
    final cls = this;
    if (cls is AppStateLoggedIn){return cls.user;} else {return null;}
  }
}

extension GetImages on AppState4{
  Iterable<Reference>? get images {
    final cls = this;
    if (cls is AppStateLoggedIn){return cls.images;} else {return null;}
  }
}

extension IfDebugging on String{String? get ifDebugging => kDebugMode ? this : null;}