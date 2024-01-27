import 'package:bloc_practice_course/bloc_example3/bloc/app_bloc.dart';
import 'package:bloc_practice_course/bloc_example3/others/constants.dart';
import 'package:bloc_practice_course/bloc_example3/views/appbloc3_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocExample3 extends StatelessWidget {
  const BlocExample3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: MultiBlocProvider(
          providers: [
            BlocProvider<BlocOne>(
              create: (_) => BlocOne(
                urls: images,
                waitBeforeLoading: const Duration(seconds:10)
              )
            ),
            BlocProvider<BlocTwo>(
              create: (_) => BlocTwo(
                urls: images, 
                waitBeforeLoading: const Duration(seconds:10)
              )
            )
          ],
          child: const Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              AppBloc3View<BlocOne>(), 
              AppBloc3View<BlocTwo>()
            ]
          )
        )
      )
    );
  }
}