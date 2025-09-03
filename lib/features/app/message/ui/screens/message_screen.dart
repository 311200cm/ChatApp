import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theming/colors.dart';
import '../../../app_logic/app_cubit.dart';
import '../../../models/user_model.dart';
import '../widgets/message_screen_app_bar.dart';
import '../widgets/send_message_field.dart';


class MessageScreen extends StatefulWidget {
  UserModel user;

  MessageScreen({super.key, required this.user});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  TextEditingController massegeController = TextEditingController();

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(100),
              child: MessageScreenAppBar(name: widget.user.name,)
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 15,
            ),
            child: BlocConsumer<AppCubit, AppState>(
              listener: (context, state) {
                if(state is SendMessageSuccessfully || state is GetHomeSuccessfully) {
                  AppCubit.get(context).getAllMessage(rid: widget.user.userId);
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
                              text: cubit.messages![index].contant,
                              color:cubit.messages![index].sendId==cubit.auth.currentUser!.uid?
                                 ColorsManger.mainBlue
                                  :ColorsManger.gray,
                              tail: true,
                              isSender:cubit.messages![index].sendId==cubit.auth.currentUser!.uid ,
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
                          itemCount: cubit.messages!.length
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SendMessageField(massegeController: massegeController,
                    user: widget.user,
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
