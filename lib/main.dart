import 'package:flutter/material.dart';
import 'LoginPage.dart';
import "auth.dart";
void main()
{
   
   runApp(new MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Login Demo',
      theme: new ThemeData(primarySwatch: Colors.lightGreen),
      home: new LoginPage(auth: new Auth(),),
      debugShowCheckedModeBanner: false,
      
    );
  }
}