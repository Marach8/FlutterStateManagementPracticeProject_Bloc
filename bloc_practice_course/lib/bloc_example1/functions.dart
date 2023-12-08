import 'dart:convert';
import 'dart:io';
import 'package:bloc_practice_course/bloc_example1/customclasses.dart';

typedef PersonsLoader = Future<Iterable<PersonData>> Function(String url);

Future <Iterable<PersonData>> getPersonsData(String url) => HttpClient()
  .getUrl(Uri.parse(url))
  .then((result) => result.close())
  .then((response) => response.transform(utf8.decoder).join())
  .then((str) => json.decode(str) as List<dynamic>)
  .then((list) => list.map((e) => PersonData.fromJson(e)));
