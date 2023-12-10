import 'package:bloc/bloc.dart';
import 'package:bloc_practice_course/bloc_example2/actions.dart';
import 'package:bloc_practice_course/bloc_example2/models.dart';
import 'package:bloc_practice_course/bloc_example2/notes_api.dart';
import 'package:bloc_practice_course/bloc_example2/app_state.dart';
import 'package:bloc_practice_course/bloc_example2/login_api.dart';

class AppBloc extends Bloc<AppAction, AppState> {
  final LoginApiProtocol loginApi;
  final NotesApiProtocol notesApi;

  AppBloc({required this.loginApi, required this.notesApi}): super(const AppState.empty()){
    on<LoginAction>((event, emit) async{
      emit(const AppState(isLoading: true, loginError: null, loginHandle: null, notes: null));
      final loginHandle = await loginApi.login(email: event.email, password: event.password);
      emit(
        AppState(
          isLoading: false, loginError: loginHandle == null? LoginErrors.invalidHandle: null, 
          loginHandle: loginHandle, notes: null
        )
      );
    });

    on<LoadNotesAction>((event, emit) async{
      final handle = state.loginHandle;
      emit(AppState(isLoading: true, loginError: null, loginHandle: handle, notes: null));
      if(handle != const LoginHandle.marach()){
        emit(AppState(isLoading: false, loginHandle: state.loginHandle, notes: null, loginError: LoginErrors.invalidHandle));
      } else{
        final notes = await notesApi.getNotes(handle: handle!);
        emit(AppState(isLoading: false, loginHandle: handle, notes: notes, loginError: null));
      }
    });
  }
}