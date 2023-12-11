import 'package:flutter/material.dart';

class IterableListView<T> extends StatelessWidget{
  final Iterable<T> iterable;
  const IterableListView({required this.iterable, super.key});
  
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: iterable.map((element) => ListTile(title: Text(element.toString()))).toList()
    );
  }
}


extension ToListView<T> on Iterable<T>{
  Widget toListView() => IterableListView(iterable: this);
}