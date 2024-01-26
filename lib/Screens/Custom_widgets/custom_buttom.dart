import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
   CustomButton(
      {super.key,
      required this.buttonColor,
      required this.buttonTitle,
      this.mWidget,
      required this.titleColor,
      required this.buttonOnTap});

  final String buttonTitle;
   Widget? mWidget;
  final Color titleColor;
  final Color buttonColor;
  final VoidCallback buttonOnTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: double.infinity,
      //decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: Colors.black),
      child: ElevatedButton(
        onPressed: buttonOnTap,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(buttonColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(21)),
          ),
        ),
        child: mWidget ?? Text(buttonTitle,style: TextStyle(color: titleColor),),
      ),
    );
  }
}
