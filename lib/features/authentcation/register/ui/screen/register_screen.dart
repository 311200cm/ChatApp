import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../../core/shared_widgets/my_text_feild.dart';
import '../../../../../core/theming/colors.dart';
import '../../../logic/auth_cubit.dart';
import '../../../../../core/shared_widgets/my_bottom.dart';
import '../../../signin/ui/screens/signin_screen.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState>formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if(state is RegisterSuccessfully){
          print("Register successfully");
          Navigator.push(context,
              MaterialPageRoute(
                  builder: (_) => SigninScreen())
          );
          name.clear();
          email.clear();
          password.clear();
        }
        if(state is RegisterWithError){
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message.toString(),
                  style: TextStyle(
                      color: ColorsManger.black,
                      fontSize: 20
                  ),
                ),
                behavior: SnackBarBehavior.floating,
                backgroundColor: ColorsManger.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10
                ),
              )
          );
        }
      },
      builder: (context, state) {
        var cubit=AuthCubit.get(context);
        return ModalProgressHUD(
          inAsyncCall: state is RegisterLoading?true:false,
          child: Scaffold(
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Form(
                key: formKey,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Text("Register",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 70,
                              backgroundColor: Colors.grey,
                            ),
                            Positioned(
                                right: 0,
                                bottom: 15,
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.blueAccent,
                                        shape: BoxShape.circle
                                    ),
                                    child: Icon(Icons.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                            )
                          ],
                        ),
                        SizedBox(
                          height: 70,
                        ),
                        MyTextField(controller: name,
                          validate: (value) {
                            if (value!.isEmpty || value == null) {
                              return "this field is required";
                            }
                            else {
                              return null;
                            }
                          },
                          hint: "Enter your name",
                          isPassword: false,
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        MyTextField(controller: email,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return "Email cannot be empty";
                            }
                            final bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value!);
                            if (!emailValid) {
                              return "Enter a valid email";
                            }
                            return null;
                          },
                          hint: "Enter your email",
                          isPassword: false,
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        MyTextField(controller: password,
                          validate: (value) {
                            if (value!.isEmpty || value == null) {
                              return "this field is required";
                            }
                            else {
                              return null;
                            }
                          },
                          hint: "Enter your password",
                          isPassword: true,
                        ),
                        SizedBox(
                          height: 50,
                        ),
                       MyBottom(text: "Register",
                            onpress: () {
                              if (formKey.currentState!.validate()) {
                                cubit.rigisterWithEmailAndPassword(
                                    name: name.text,
                                    email: email.text,
                                    password: password.text
                                );
                              }
                              else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Register is failed",
                                        style: TextStyle(
                                            color: ColorsManger.black,
                                            fontSize: 20
                                        ),
                                      ),
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: ColorsManger.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 10
                                      ),
                                    )
                                );
                              }
                            }
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context,
                              MaterialPageRoute(builder: (_)=>SigninScreen())
                            );
                          },
                          child: Text("Signin",
                          style: TextStyle(
                            fontSize: 25,
                            color: ColorsManger.mainBlue
                          ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
