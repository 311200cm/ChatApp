import 'package:flutter/material.dart';
import 'package:my_chat_app/Features/App/App_Logic/app_cubit.dart';
import 'package:my_chat_app/Features/App/Message/UI/Screens/Message_Screen.dart';
import 'package:my_chat_app/core/Helpers/Models/User_Model.dart';
import 'package:my_chat_app/core/Helpers/theming/Colors.dart';

import '../../../../../core/Helpers/String/app_Images.dart';

class UserCard extends StatelessWidget {
  UserModel user;
   UserCard({super.key,required this.user});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        AppCubit.get(context).GetAllMessage(rid: user.UId);
        Navigator.push(context,
            MaterialPageRoute(builder: (_)=>MessageScreen(User:user ,))
        );
      },
      child: Card(
        color: ColorsManger.White54,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              radius: 45,
              backgroundImage:AssetImage(UserImage) ,
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
                    color: ColorsManger.Black
                  ),
                  ),
                  Text(user.Email??"No Email",
                    style: TextStyle(
                        fontSize: 20,
                        color: ColorsManger.Black
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
