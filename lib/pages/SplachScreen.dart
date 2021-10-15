import 'dart:async';
import 'package:changilni_employee/pages/SignInPage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';



class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds:5),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (
              BuildContext context) =>SignInPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     //#2CD889
      backgroundColor: Color(0xffE4E4E4),
      body: Column(
           crossAxisAlignment:CrossAxisAlignment.center,
          children: <Widget>[
             SizedBox(
            height: 200,
          ),Center(
            child:Lottie.asset('assets/lottie/employee1.json',
            width: 300,
            height: 300,
            fit: BoxFit.fill,)),
             SizedBox(
            height: 100,
          ),
            Center(
              child:Text(
                  "Voir les voitures mal stationnées",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xff27313B),
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,) 
                ),)]
      ),
    );
  }

  
}