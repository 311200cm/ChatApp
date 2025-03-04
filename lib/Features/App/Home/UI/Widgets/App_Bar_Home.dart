import 'package:flutter/material.dart';
import 'package:my_chat_app/core/Helpers/theming/Colors.dart';

class AppBarHome extends StatelessWidget {
  const AppBarHome({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorsManger.White,
      flexibleSpace: Padding(
        padding: const EdgeInsets.only(
          top: 40,
          left: 20
        ),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Chat App",

            style: TextStyle(
              color: ColorsManger.Black,
              fontSize: 30,
              fontWeight: FontWeight.w700
            ),
            ),
            Row(
              children: [
                Icon(Icons.camera_alt_outlined,
                  size: 40,
                  color: ColorsManger.Black,
                ),
                Icon(Icons.more_vert,
                        size: 40,
                        color: ColorsManger.Black,
                      ),
              ],
            )
          ],
        )
      ),
      // actions: [
      //   Padding(
      //     padding: const EdgeInsets.only(
      //       top: 40
      //     ),
      //     child: Icon(Icons.camera_alt_outlined,
      //     size: 40,
      //     color: ColorsManger.Black,
      //     ),
      //   ),
      //   Padding(
      //     padding: const EdgeInsets.only(
      //       top: 40
      //     ),
      //     child: Icon(Icons.more_vert,
      //       size: 40,
      //       color: ColorsManger.Black,
      //     ),
      //   ),
      // ],
    );
  }
}
