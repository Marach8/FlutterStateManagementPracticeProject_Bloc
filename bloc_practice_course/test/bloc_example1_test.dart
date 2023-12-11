// // This is a basic Flutter widget test.
// //
// // To perform an interaction with a widget in your test, use the WidgetTester
// // utility in the flutter_test package. For example, you can send tap and scroll
// // gestures. You can also use WidgetTester to find child widgets in the widget
// // tree, read text, and verify that the values of widget properties are correct.

// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';

// import 'package:bloc_practice_course/main.dart';

// void main() {
//   testWidgets('Counter increments smoke test', (WidgetTester tester) async {
//     // Build our app and trigger a frame.
//     await tester.pumpWidget(const MyApp());

//     // Verify that our counter starts at 0.
//     expect(find.text('0'), findsOneWidget);
//     expect(find.text('1'), findsNothing);

//     // Tap the '+' icon and trigger a frame.
//     await tester.tap(find.byIcon(Icons.add));
//     await tester.pump();

//     // Verify that our counter has incremented.
//     expect(find.text('0'), findsNothing);
//     expect(find.text('1'), findsOneWidget);
//   });
// }


import 'package:bloc_practice_course/bloc_example1/actions.dart';
import 'package:bloc_practice_course/bloc_example1/customclasses.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

final mockedPerson1 = [
  PersonData(name: 'Emmanuel', age: 20),
  PersonData(name: 'Daniel', age: 29)
];

final mockedPerson2 = [
  PersonData(name: 'Emmanuel', age: 20),
  PersonData(name: 'Daniel', age: 29)
];

Future<Iterable<PersonData>> getMockedPerson1(String _) => 
  Future.value(mockedPerson1);

Future<Iterable<PersonData>> getMockedPerson2(String _) => 
  Future.value(mockedPerson2);


void main(){
  group('Testing the bloc', (){
    late PersonBloc bloc;
    
    setUp(() {
      bloc = PersonBloc();
    });

    blocTest<PersonBloc, FetchedResults?>(
      'Test initial state',
      build: () => bloc, 
      verify: (bloc) =>  expect(bloc.state, null)
    );

    blocTest(
      'Mock retrieving persons from first iterable',
      build: () => bloc,
      act: (bloc) {
        bloc.add(const LoadingPersonsAction(url: 'dummy_url1', loader: getMockedPerson1));
        bloc.add(const LoadingPersonsAction(url: 'dummy_url1', loader: getMockedPerson1));
      },
      expect: () => [
        FetchedResults(persons: mockedPerson1, isRetrievedFromCache: false),
        FetchedResults(persons: mockedPerson1, isRetrievedFromCache: true)
      ]
    );

    blocTest(
      'Mock retrieving persons from second iterable',
      build: () => bloc,
      act: (bloc) {
        bloc.add(const LoadingPersonsAction(url: 'dummy_url2', loader: getMockedPerson2));
        bloc.add(const LoadingPersonsAction(url: 'dummy_url2', loader: getMockedPerson2));
      },
      expect: () => [
        FetchedResults(persons: mockedPerson2, isRetrievedFromCache: false),
        FetchedResults(persons: mockedPerson2, isRetrievedFromCache: true)
      ]
    );
  });
}