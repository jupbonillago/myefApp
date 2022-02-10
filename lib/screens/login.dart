import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: ElevatedButton(
      //TODO:
      child: Text("Login Test",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0)),
      //example with an arrow function to return a nameless function
      onPressed: () {
        Navigator.pushReplacementNamed(context, '/home');
      },
    )));
  }
}
