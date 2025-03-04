import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_chat_app/Features/App/App_Logic/app_cubit.dart';
import 'package:my_chat_app/Features/App/Message/UI/Widget/Message_Screen_App_Bar.dart';
import 'package:my_chat_app/Features/App/Message/UI/Widget/Send_Message_Field.dart';
import 'package:my_chat_app/core/Helpers/Models/User_Model.dart';
import 'package:my_chat_app/core/Helpers/theming/Colors.dart';

import '../../../../../core/Helpers/String/app_Images.dart';

class MessageScreen extends StatefulWidget {
  UserModel User;

  MessageScreen({super.key, required this.User});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  TextEditingController MassegeController = TextEditingController();

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(100),
              child: MessageScreenAppBar(name: widget.User.name,)
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 15,
            ),
            child: BlocConsumer<AppCubit, AppState>(
              listener: (context, state) {
                if(state is SendMessageSuccessfully || state is GetHomeSuccessfully) {
                  AppCubit.get(context).GetAllMessage(rid: widget.User.UId);
                }
              },
              builder: (context, state) {
                var cubit = AppCubit.get(context);
                return Column(
                  children: [
                    Expanded(
                      flex: 6,
                      child:ListView.separated(
                        // physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return BubbleSpecialThree(
                              text: cubit.Messages![index].contant,
                              color:cubit.Messages![index].SendId==cubit.auth.currentUser!.uid?
                                 ColorsManger.MainBlue
                                  :ColorsManger.Gray,
                              tail: true,
                              isSender:cubit.Messages![index].SendId==cubit.auth.currentUser!.uid ,
                              textStyle: TextStyle(
                                  fontSize: 16
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 30,
                            );
                          },
                          itemCount: cubit.Messages!.length
                      ),
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    SendMessageField(MassegeController: MassegeController,
                    User: widget.User,
                    )
                  ],
                );
              },
            ),
          )
      ),
    );
  }
}
