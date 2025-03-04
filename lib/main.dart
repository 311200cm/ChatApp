import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_chat_app/Features/App/App_Logic/app_cubit.dart';
import 'package:my_chat_app/Features/App/Home/UI/Screen/Home_Screen.dart';
import 'package:my_chat_app/Features/Authentcation/Signin/UI/Screens/Signin_Screen.dart';
import 'Features/Authentcation/Register/Ui/screen/Register_screen.dart';
import 'Features/Authentcation/logic/auth_cubit.dart';
import 'firebase_options.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
 await FirebaseAuth.instance.signOut();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
            create:(context)=>AppCubit()..GetHome()
        )
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home:FirebaseAuth.instance.currentUser?.uid !=null?HomeScreen()
          :RegisterScreen()
      ),
    );
  }
}

