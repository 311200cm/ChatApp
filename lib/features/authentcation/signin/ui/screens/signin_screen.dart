import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../../core/shared_widgets/my_text_feild.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../app/home/ui/screen/home_screen.dart';
import '../../../logic/auth_cubit.dart';
import '../../../../../core/shared_widgets/my_bottom.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  @override
  GlobalKey<FormState>formKey=GlobalKey();
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignInWithError) {
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
                  borderRadius: BorderRadius.circular(
                      12),
                ),
                margin: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10
                ),
              )
          );
        }

        else if(state is SignInSuccessfully){
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (_)=>HomeScreen()),
                  (route)=>false
          );
        }
      },
      builder: (context, state) {
        var cubit=AuthCubit.get(context);
        return ModalProgressHUD(
          inAsyncCall: state is SignInLoading ? true : false,
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back,
                  size: 50,
                  )
              ),
            ),
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
                        Text("SignIn",
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
                        MyBottom(text: "Sign In",
                            onpress: () {
                              if (formKey.currentState!.validate()) {
                               cubit.signInWithEmailAndPassword(
                                   email: email.text
                                   , password: password.text
                               );
                              }
                              else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("SignIn is failed",
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
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
