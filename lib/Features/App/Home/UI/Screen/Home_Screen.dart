import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_chat_app/Features/App/App_Logic/app_cubit.dart';
import 'package:my_chat_app/Features/App/Home/UI/Widgets/App_Bar_Home.dart';
import 'package:my_chat_app/Features/App/Home/UI/Widgets/User_Card.dart';
import 'package:my_chat_app/core/Helpers/theming/Colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {
          if (state is GetHomeWithError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                state.message.toString(),
                style: TextStyle(color: ColorsManger.Black, fontSize: 20),
              ),
              behavior: SnackBarBehavior.floating,
              backgroundColor: ColorsManger.White,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            ));
          }
        },
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          if(state is GetHomeLoading){
            return Center(
              child: CircularProgressIndicator(
                color: ColorsManger.White,
              ),
            );
          }
         else  {
            return Scaffold(
                backgroundColor: ColorsManger.White,
                appBar: PreferredSize(
                    preferredSize: Size.fromHeight(150), child: AppBarHome()),
                body: ListView.separated(
                    itemBuilder: (context, index) {
                      return UserCard(user: cubit.Users![index]);
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: ColorsManger.White10,
                        height: 30,
                      );
                    },
                    itemCount: cubit.Users.length));
          }
         // else{
         //   return Center(
         //     child: Text("No Data",
         //       style: TextStyle(
         //           fontSize: 50,
         //           fontWeight: FontWeight.bold
         //       ),
         //     ),
         //   );
         //  }
        },
      ),
    );
  }
}
