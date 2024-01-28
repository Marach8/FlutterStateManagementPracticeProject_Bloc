import 'package:bloc_practice_course/bloc_example4/bloc/app_bloc.dart';
import 'package:bloc_practice_course/bloc_example4/bloc/app_events.dart';
import 'package:bloc_practice_course/bloc_example4/extentions/extensions.dart';
import 'package:bloc_practice_course/bloc_example4/views/image_view.dart';
import 'package:bloc_practice_course/bloc_example4/views/pop_up_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';

class PhotoGalleryView extends HookWidget {
  const PhotoGalleryView({super.key});

  @override
  Widget build(BuildContext context) {
    final picker = useMemoized(
      () => ImagePicker(), 
      [key]
    );
    final images = context.watch<AppBloc4>()
      .state.images ?? [];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Manager'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async{
              await picker.pickImage(source: ImageSource.gallery)
              .then((image){
                image != null 
                  ? context.read<AppBloc4>().add(
                    UploadImageAppEvent(filePath: image.path)
                  ) : {};
              });
            },
            icon: const Icon(Icons.upload)
          ),
          const MenuPopUpButton()
        ]
      ),
      body: GridView.count(
        crossAxisCount: 2, 
        padding: const EdgeInsets.all(5),
        mainAxisSpacing: 5, 
        crossAxisSpacing: 5,
        children: images.map(
          (img) => ImageView(image: img)
        ).toList()
      )
    );
  }
}