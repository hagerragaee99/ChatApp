// ignore_for_file: must_be_immutable

import 'package:cubitproject/Widgets/Custom_Button.dart';
import 'package:cubitproject/Widgets/Custom_TextFormField.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'images/icons8-chat-room-100.png',
                  width: 120,
                  fit: BoxFit.fill,
                ),
                Text(
                  'Welcome to Chat App',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 95, 175, 241),
                  ),
                ),
                CustomTextformfield(hintText: 'Enter Your Username'),
                CustomTextformfield(hintText: 'Enter Your Email'),
                CustomTextformfield(hintText: 'Enter Your Password'),
                CustomTextformfield(hintText: 'Confirm Your Password'),

                CustomButton(text: "Register"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
