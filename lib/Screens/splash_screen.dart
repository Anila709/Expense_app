import 'dart:async';

import 'package:expenses_app/Screens/add_expense.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {



  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 6), () { 
      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AddExpenses()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff45B379),
      body: Center(
        child: Lottie.asset('assets/lottie/expense.json',width: 250,height: 250),
      ),
    );
  }
}