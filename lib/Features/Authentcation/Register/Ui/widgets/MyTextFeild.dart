import 'package:flutter/material.dart';

class Mytextfield extends StatefulWidget {
  TextEditingController controller;
  String?Function(String?)validate;
  String hint;
  bool IsPassword;
  Mytextfield({super.key, required this.controller,required this.validate,
    required this.hint, required this.IsPassword
  });

  @override
  State<Mytextfield> createState() => _MytextfieldState();
}

class _MytextfieldState extends State<Mytextfield> {
  bool secure=false;
  void initState(){
    super.initState();
    secure= widget.IsPassword;
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
          suffixIcon: widget.IsPassword?IconButton(
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