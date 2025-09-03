import 'package:flutter/material.dart';

import '../../../../../core/theming/colors.dart';


class AppBarHome extends StatelessWidget {
  const AppBarHome({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorsManger.white,
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
              color: ColorsManger.black,
              fontSize: 30,
              fontWeight: FontWeight.w700
            ),
            ),
            Row(
              children: [
                Icon(Icons.camera_alt_outlined,
                  size: 40,
                  color: ColorsManger.black,
                ),
                Icon(Icons.more_vert,
                        size: 40,
                        color: ColorsManger.black,
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
