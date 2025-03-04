import 'package:flutter/material.dart';
import 'package:my_chat_app/Features/App/App_Logic/app_cubit.dart';
import 'package:my_chat_app/core/Helpers/Models/User_Model.dart';

class SendMessageField extends StatefulWidget {
  TextEditingController MassegeController;
  UserModel User;
   SendMessageField({super.key,required this.MassegeController,
   required this.User
   });

  @override
  State<SendMessageField> createState() => _SendMessageFieldState();
}

class _SendMessageFieldState extends State<SendMessageField> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 6,
          child: TextFormField(
            controller:widget.MassegeController,
            decoration: InputDecoration(
                hintText: "Enter your message",
                hintStyle: TextStyle(
                    fontSize: 25,
                    color: Colors.grey
                ),
                border:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                )
            ),
          ),
        ),
        Expanded(
            flex: 1,
            child:CircleAvatar(
              backgroundColor: Colors.blueAccent,
              radius: 30,
              child:IconButton(onPressed: (){
                AppCubit.get(context).SendMessage(
                    contant:widget.MassegeController.text,
                    Rid: widget.User.UId
                );
               widget.MassegeController.clear();
              },
                  icon:Icon(Icons.send,
                    size: 20,
                    color: Colors.white,
                  )
              ),
            )
        )
      ],
    );
  }
}
