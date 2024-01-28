import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  final Reference image;
  const ImageView({
    required this.image, 
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      future: image.getData(),
      builder: (context, snapshot){
        switch(snapshot.connectionState){
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            return const Center(
              child: CircularProgressIndicator()
            );
          case ConnectionState.done:
            if(snapshot.hasData){
              return Image.memory(
                snapshot.data!, 
                fit: BoxFit.cover
              );
            } else {
              return const Center(
                child: Text("Couldn't Load Image")
              );
            }
        }
      }
    );
  }
}