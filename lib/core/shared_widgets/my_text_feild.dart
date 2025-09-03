import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  TextEditingController controller;
  String?Function(String?)validate;
  String hint;
  bool isPassword;
  MyTextField({super.key, required this.controller,required this.validate,
    required this.hint, required this.isPassword
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool secure=false;
  void initState(){
    super.initState();
    secure= widget.isPassword;
  }
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: (){
        widget.controller.clear();
      },
      keyboardType: TextInputType.none,
      validator:widget.validate,
      obscureText: secure,
      controller: widget.controller,
      decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          border: OutlineInputBorder(
            borderSide:BorderSide(
                color: Colors.red,
                width: 1
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          errorBorder:OutlineInputBorder(
            borderSide:BorderSide(
                color: Colors.red,
                width: 1
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          suffixIcon: widget.isPassword?IconButton(
            onPressed: (){
              secure=!secure;
              setState(() {

              });
            }, icon: secure?Icon(Icons.visibility_off_outlined)
              :Icon(Icons.visibility_outlined),
          ) :null
      ),
    );
  }
}