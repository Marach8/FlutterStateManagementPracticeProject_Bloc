import 'package:bloc_practice_course/bloc_example4/bloc/app_bloc.dart';
import 'package:bloc_practice_course/bloc_example4/bloc/app_events.dart';
import 'package:bloc_practice_course/bloc_example4/dialogs/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum MenuAction{logout, deleteAccount}

class MenuPopUpButton extends StatelessWidget {
  const MenuPopUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuAction>(
      itemBuilder: (context) => [
        const PopupMenuItem<MenuAction>(
          value: MenuAction.logout, 
          child: Text('LogOut')
        ),
        const PopupMenuItem<MenuAction>(
          value: MenuAction.deleteAccount, 
          child: Text('Delete Account')
        )
      ],
      onSelected: (value) async{
        switch(value){
          case MenuAction.logout: 
            await logOutDialog(context: context)
            .then((result){
              result == true ? context.read<AppBloc4>()
                .add(const LogoutUserAppEvent()) : {};
            });
            break;           
          case MenuAction.deleteAccount:
            await deletAccountDialog(context: context)
            .then((result){
              result == true ? context.read<AppBloc4>()
              .add(const DeleteAccountAppEvent()) : {};
            });  
            break;
        }
      }
    );
  }
}