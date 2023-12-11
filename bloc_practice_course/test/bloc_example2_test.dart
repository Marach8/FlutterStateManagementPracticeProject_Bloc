import 'package:bloc_practice_course/bloc_example2/api/login_api.dart';
import 'package:bloc_practice_course/bloc_example2/api/notes_api.dart';
import 'package:bloc_practice_course/bloc_example2/bloc/app_bloc.dart';
import 'package:bloc_practice_course/bloc_example2/bloc/app_state.dart';
import 'package:bloc_practice_course/bloc_example2/others/actions.dart';
import 'package:bloc_practice_course/bloc_example2/others/models.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

const Iterable<Note> mockNotes  = [Note(title: 'Note1'), Note(title: 'Note2'), Note(title: 'Note3')];

@immutable 
class TestNotesApi implements NotesApiProtocol{
  final LoginHandle acceptedLoginHandle;
  final Iterable<Note>? notesReturnedForAcceptedLoginHandle;

  const TestNotesApi({required this.acceptedLoginHandle, required this.notesReturnedForAcceptedLoginHandle});

  const TestNotesApi.empty(): 
  acceptedLoginHandle = const LoginHandle.marach(), notesReturnedForAcceptedLoginHandle = null;

  @override
  Future<Iterable<Note>?> getNotes({required LoginHandle handle}) async{
    if (handle == acceptedLoginHandle){return notesReturnedForAcceptedLoginHandle;} else{return null;}
  }
}


@immutable 
class TestLoginApi implements LoginApiProtocol{
  final String testEmail, testPassword; final LoginHandle testHandle;
  const TestLoginApi({required this.testHandle, required this.testEmail, required this.testPassword});

  const TestLoginApi.empty(): testEmail = '', testPassword = '', testHandle = const LoginHandle.marach();
  
  @override
  Future<LoginHandle?> login({required String email, required String password}) async {
    if(email == testEmail && password == testPassword){return testHandle;} else{return null;}
  }
}


const acceptedHandle = LoginHandle(token: 'Emma');
void main(){
  blocTest<AppBloc, AppState>(
    'Initial state of the bloc should be AppState.empty()',
    build: () => AppBloc(
      loginApi: const TestLoginApi.empty(), notesApi: const TestNotesApi.empty(),
      acceptableLoginHandle: acceptedHandle
    ),
    verify: (appState) => expect(appState.state, const AppState.empty())
  );

  blocTest<AppBloc, AppState>(
    'Can we log in with correct credentials?',
    build: () => AppBloc(
      loginApi: const TestLoginApi(
        testEmail: 'david@gmail.com', testPassword: 'David', testHandle: acceptedHandle
      ), 
      notesApi: const TestNotesApi.empty(),
      acceptableLoginHandle: acceptedHandle
    ),
    act: (appBloc) => appBloc.add(const LoginAction(email: 'david@gmail.com', password: 'David')),
    expect: () => [
      const AppState(isLoading: true, loginHandle: null, loginError: null, notes: null),
      const AppState(isLoading: false, loginHandle: acceptedHandle, notes: null, loginError: null)
    ]
  );

   blocTest<AppBloc, AppState>(
    'We must not be able to log in with invalid credentials',
    build: () => AppBloc(
      loginApi: const TestLoginApi(
        testEmail: 'david@gmail.com', testPassword: 'David', testHandle: acceptedHandle
      ), 
      notesApi: const TestNotesApi.empty(),
      acceptableLoginHandle: acceptedHandle
    ),
    act: (appBloc) => appBloc.add(const LoginAction(email: 'nnanna@gmail.com', password: 'Nnanna')),
    expect: () => [
      const AppState(isLoading: true, loginHandle: null, loginError: null, notes: null),
      const AppState(isLoading: false, loginHandle: null, notes: null, loginError: LoginErrors.invalidHandle)
    ]
  );

  blocTest<AppBloc, AppState>(
    'Load Some notes with a valid Login Handle',
    build: () => AppBloc(
      loginApi: const TestLoginApi(
        testEmail: 'david@gmail.com', testPassword: 'David', testHandle: acceptedHandle
      ), 
      notesApi: const TestNotesApi(
        acceptedLoginHandle: acceptedHandle, notesReturnedForAcceptedLoginHandle: mockNotes
      ),
      acceptableLoginHandle: acceptedHandle
    ),
    act: (appBloc) {
      appBloc.add(const LoginAction(email: 'david@gmail.com', password: 'David'));
      appBloc.add(const LoadNotesAction());
    },
    expect: () => [
      const AppState(isLoading: true, loginHandle: null, loginError: null, notes: null),
      const AppState(isLoading: false, loginHandle: acceptedHandle, notes: null, loginError: null),
      const AppState(isLoading: true, loginHandle: acceptedHandle, loginError: null, notes: null),
      const AppState(isLoading: false, loginHandle: acceptedHandle, loginError: null, notes: mockNotes)
    ]
  );
}
