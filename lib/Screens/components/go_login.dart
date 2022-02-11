import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lbz/Screens/components/components.dart';
import 'package:lbz/shared/styles/colors.dart';

Widget goLogin(){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children:
    [
      const Text('Please Login to get profile',style: TextStyle(fontSize: 25,color: redDefaultColor),),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 8),
        child: button('I want to login', Icons.login,color: redDefaultColor,clr: Colors.white),
      ),
    ],
  );
}