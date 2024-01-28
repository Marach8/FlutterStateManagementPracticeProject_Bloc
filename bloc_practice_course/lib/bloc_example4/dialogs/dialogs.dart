import 'package:bloc_practice_course/bloc_example2/custom_widgets/generic_dialog.dart';
import 'package:bloc_practice_course/bloc_example4/auth/auth_errors.dart';
import 'package:flutter/material.dart';

Future<bool?> deletAccountDialog({required BuildContext context}) 
  => showGenericDialog<bool?>(
    context: context, title: 'Delete Account',
    content: 'Are you sure you want to delete your account?',
    optionsBuilder: () => {'Cancel': false, 'Delete': true}
  ).then((value) => value ?? false);


Future<bool?> logOutDialog({required BuildContext context}) 
  => showGenericDialog<bool?>(
    context: context, title: 'Log Out',
    content: 'Are you sure you want to Log out?',
    optionsBuilder: () => {'Cancel': false, 'Log Out': true}
  ).then((value) => value ?? false);


Future<void> authErrorDialog({
  required BuildContext context, 
  required AuthError error
}) 
  => showGenericDialog<void>(
    context: context, title: error.title,
    content: error.content,
    optionsBuilder: () => {'Ok': true}
  );