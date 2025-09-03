import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/app/app_logic/app_cubit.dart';
import 'features/app/home/ui/screen/home_screen.dart';
import 'features/authentcation/logic/auth_cubit.dart';
import 'features/authentcation/register/ui/screen/register_screen.dart';
import 'firebase_options.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
 // await FirebaseAuth.instance.signOut();
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
            create:(context)=>AppCubit()..getHome()
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

