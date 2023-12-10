import 'package:flutter/material.dart';

typedef DialogOptions<T> = Map<String, T?> Function();

Future<T?> showGenericDialog<T>({
  required BuildContext context, required String title, content, 
  required DialogOptions optionsBuilder
}){
  final options = optionsBuilder();
  return showDialog<T?>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title), content: Text(content),
      actions: options.keys.map((optionsKey){
        final optionsValue = options[optionsKey];
        return TextButton(
          onPressed: (){
            if(optionsValue == null){Navigator.pop(context);}
            else {Navigator.of(context).pop(optionsValue);}
          },
          child: Text(optionsKey)
        );
      }).toList()
    )
  );
}