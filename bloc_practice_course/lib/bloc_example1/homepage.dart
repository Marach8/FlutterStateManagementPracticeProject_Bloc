import 'package:bloc_practice_course/bloc_example1/actions.dart';
import 'package:bloc_practice_course/bloc_example1/customclasses.dart';
import 'package:bloc_practice_course/bloc_example1/extensions_and_enums.dart';
import 'package:bloc_practice_course/bloc_example1/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class BlocExample1 extends StatelessWidget {
  const BlocExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PersonBloc(),
      builder: (context1, __) =>Scaffold(
        appBar: AppBar(
          centerTitle: true, 
          title: const Text('Flutter Bloc Example1')
        ),
        body: Column(
          children: [
            Row(
              children: [
                TextButton(
                  onPressed: () => context1.read<PersonBloc>()
                  .add(
                    LoadingPersonsAction(
                      url: PersonsUrl.persons1.urlString, 
                      loader: getPersonsData
                    )
                  ),
                  child: const Text('Load Json1')
                ),
                TextButton(
                  onPressed: () => context1.read<PersonBloc>()
                  .add(
                    LoadingPersonsAction(
                      url: PersonsUrl.persons2.urlString, 
                      loader: getPersonsData
                    )
                  ),
                  child: const Text('Load Json2')
                ),
              ]
            ),
            BlocBuilder<PersonBloc, FetchedResults?>(
              buildWhen: (previousFetchedResults, currentFetchedResults) =>
                previousFetchedResults?.persons != currentFetchedResults?.persons,
              builder: (context, fetchedResults){
                final fetchedPersons = fetchedResults?.persons;
                if (fetchedPersons == null){
                  return const SizedBox();
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: fetchedPersons.length,
                    itemBuilder: (context, listIndex){
                      final fetchedPerson = fetchedPersons[listIndex]!;
                      return ListTile(
                        title: Text(fetchedPerson.name)
                      );
                    }
                  ),
                );
              }
            )
          ]
        )
      ),
    );
  }
}
