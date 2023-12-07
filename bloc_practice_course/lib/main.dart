import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(backgroundColor: Colors.blue),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late final NamesCubit namesCubit;

  @override 
  void initState(){super.initState; namesCubit = NamesCubit();}

  @override 
  void dispose(){namesCubit.close(); super.dispose();}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cubit Example'), centerTitle: true), 
      body: StreamBuilder<String?> (
        stream: namesCubit.stream,
        builder: (context, snapshot){
          final Widget button = TextButton(
            onPressed: () => namesCubit.newCubitState(),
            child: const Text('Pick a random name')
          );
          switch (snapshot.connectionState){
            case ConnectionState.none:
              return button;
            case ConnectionState.waiting:
              return button;
            case ConnectionState.active:
              return Column(children: [button, Text(snapshot.data ?? '')],);
            case ConnectionState.done:
              return const SizedBox();
          }
        }
      )
    );
  }
}






const names = ['Emmanuel', 'David', 'Emeka', 'Daniel'];

class NamesCubit extends Cubit<String?> {
  NamesCubit(): super(null);

  void newCubitState() => emit(names.marach());
}

extension Marach<T> on Iterable<T>{
  T marach() => elementAt(Random().nextInt(length));
}
