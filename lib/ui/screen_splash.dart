import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScreenPage extends StatefulWidget {
  @override
  _ScreenPageState createState() => _ScreenPageState();
}

class _ScreenPageState extends State<ScreenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("Welcome to Mr.Stein's Book Store",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Pacifico'),),
        ),
      ),
    );
  }
}