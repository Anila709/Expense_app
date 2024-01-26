import 'package:flutter/material.dart';

class UIHelper{

  //light theme color..
  static final mPrimaryLightColor=Colors.orange;
  static final mSecondaryLightColor=Colors.white;


  //dark theme color..
  static final mPrimaryDarkColor=Colors.orange;
  static final mSecondaryDarkColor=Colors.black;
 
}

//package level declaration..
 TextStyle mTextStyle43({
    Color fontColor=Colors.blue,
    FontWeight fontWeight=FontWeight.w500,
  }){
    return TextStyle(
      fontSize: 43,
      color: fontColor,
      fontWeight:fontWeight ,
      fontFamily: 'Poppins',
    );
  }