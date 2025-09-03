import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theming/colors.dart';
import '../../../app_logic/app_cubit.dart';
import '../widgets/app_bar_home.dart';
import '../widgets/user_card.dart';


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
                style: TextStyle(color: ColorsManger.black, fontSize: 20),
              ),
              behavior: SnackBarBehavior.floating,
              backgroundColor: ColorsManger.white,
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
                color: ColorsManger.white,
              ),
            );
          }
         else  {
            return Scaffold(
                backgroundColor: ColorsManger.white,
                appBar: PreferredSize(
                    preferredSize: Size.fromHeight(150), child: AppBarHome()),
                body: ListView.separated(
                    itemBuilder: (context, index) {
                      return UserCard(user: cubit.users![index]);
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: ColorsManger.white10,
                        height: 30,
                      );
                    },
                    itemCount: cubit.users.length));
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
