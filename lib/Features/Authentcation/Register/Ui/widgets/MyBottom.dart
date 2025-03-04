import 'package:flutter/material.dart';

class MyBottom extends StatelessWidget {
  String text;
  VoidCallback onpress;
  MyBottom({super.key,required this.text , required this.onpress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: GestureDetector(
        onTap: onpress,
        child: Container(
          width: double.infinity,
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.blueAccent,
          ),
          child:Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(text,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),
              textAlign:TextAlign.center,
            ),
          ) ,
        ),
      ),
    );
  }
}