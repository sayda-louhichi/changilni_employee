
import 'package:changilni_employee/releve/Releves.dart';
import "package:flutter/material.dart";
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE4E4E4),
    body: SingleChildScrollView(
        child: Releves(
          url: "/releve/getReleve",
        ),
      ),
    );
  }
}