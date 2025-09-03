import 'package:flutter/material.dart';
import 'package:my_chat_app/core/string/app_images.dart';


class MessageScreenAppBar extends StatelessWidget {
  String name;
   MessageScreenAppBar({super.key,
   required this.name});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: Padding(
        padding: const EdgeInsets.only(
          top: 40,
        ),
        child: Row(
          children: [
            IconButton(onPressed: (){
              Navigator.pop(context);
            }, icon: Icon(Icons.arrow_back,
              size: 30,
            )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(userImage,),
                  radius: 35,
                ),
                SizedBox(
                  width:20 ,
                ),
                Text(name,
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
