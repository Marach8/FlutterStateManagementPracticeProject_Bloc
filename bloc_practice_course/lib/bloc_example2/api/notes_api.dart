import 'package:bloc_practice_course/bloc_example2/others/models.dart';
import 'package:flutter/material.dart';

@immutable 
abstract class NotesApiProtocol{
  const NotesApiProtocol();
  Future<Iterable<Note>?> getNotes({required LoginHandle handle});
}

@immutable 
class NotesApi implements NotesApiProtocol{
  @override
  Future<Iterable<Note>?> getNotes({required LoginHandle handle}) 
    => Future.delayed(const Duration(seconds: 2), 
    () => handle == const LoginHandle.marach()? mockNotes: null);
}

final mockNotes = Iterable.generate(3, (a) => Note(title: 'Note ${a + 1}'));