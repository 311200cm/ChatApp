import 'package:flutter/material.dart';
import 'package:my_chat_app/core/string/app_images.dart';

import '../../../../../core/theming/colors.dart';
import '../../../app_logic/app_cubit.dart';
import '../../../message/ui/screens/message_screen.dart';
import '../../../models/user_model.dart';


class UserCard extends StatelessWidget {
  UserModel user;
   UserCard({super.key,required this.user});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        AppCubit.get(context).getAllMessage(rid: user.userId);
        Navigator.push(context,
            MaterialPageRoute(builder: (_)=>MessageScreen(user:user ,))
        );
      },
      child: Card(
        color: ColorsManger.white54,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              radius: 45,
              backgroundImage:AssetImage(userImage) ,
            ),
            SizedBox(
              width: 30,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.name??"No Name",
                  style: TextStyle(
                    fontSize: 20,
                    color: ColorsManger.black
                  ),
                  ),
                  Text(user.email??"No Email",
                    style: TextStyle(
                        fontSize: 20,
                        color: ColorsManger.black
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
