import 'package:bloc/bloc.dart';
import 'package:bloc_practice_course/bloc_example1/actions.dart';
import 'package:bloc_practice_course/bloc_example1/extensions_and_enums.dart';
import 'package:flutter/material.dart';


class PersonData{
  final String name; final int age;
  PersonData({required this.name, required this.age});

  PersonData.fromJson(Map<String, dynamic> json): 
    name = json['name'] as String, age = json['age'] as int;
}


@immutable 
class FetchedResults{
  final Iterable<PersonData> persons; final bool isRetrievedFromCache;
  const FetchedResults({required this.persons, required this.isRetrievedFromCache});

  @override 
  toString() => "Fetched Results (isRetrived: $isRetrievedFromCache , persons: $persons)";

  @override
  bool operator ==(covariant FetchedResults other) =>
  persons.isEqualIgnoringOrder(other.persons) && isRetrievedFromCache == other.isRetrievedFromCache;
  
  @override
  int get hashCode => Object.hash(persons, isRetrievedFromCache);  
}


class PersonBloc extends Bloc<LoadingAction, FetchedResults?>{
  final Map<String, Iterable<PersonData>> _cache = {};
  PersonBloc(): super(null){
    on<LoadingPersonsAction>((event, emit) async{
      final url = event.url;
      print('This is the url: $url');
      if (_cache.containsKey(url)){
        print('block 1 was executed');
        final cachedPerson = _cache[url]!;
        final result = FetchedResults(isRetrievedFromCache: true, persons: cachedPerson);
        emit(result);
      } else{ 
        print('block 2 was executed');
        final loader = event.loader;
        final persons = await loader(url);
        _cache[url] = persons;
        final result = FetchedResults(isRetrievedFromCache: false, persons: persons);
        emit(result);
      }
    });
  }
}

