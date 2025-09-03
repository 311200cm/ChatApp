import 'package:flutter/material.dart';

import '../../../app_logic/app_cubit.dart';
import '../../../models/user_model.dart';


class SendMessageField extends StatefulWidget {
  TextEditingController massegeController;
  UserModel user;
   SendMessageField({super.key,required this.massegeController,
   required this.user
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
            controller:widget.massegeController,
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
              radius: 40,
              child:IconButton(onPressed: (){
                AppCubit.get(context).sendMessage(
                    contant:widget.massegeController.text,
                    rid: widget.user.userId
                );
               widget.massegeController.clear();
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
