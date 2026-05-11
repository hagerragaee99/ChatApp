// ignore_for_file: must_be_immutable

import 'package:cubitproject/Screens/Register_Screen.dart';
import 'package:cubitproject/Widgets/Custom_Button.dart';
import 'package:cubitproject/Widgets/Custom_TextFormField.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

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
                  'Welcome Back to Chat App',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 95, 175, 241),
                  ),
                ),
                CustomTextformfield(hintText: 'Enter Your Email'),
                CustomTextformfield(hintText: 'Enter Your Password'),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Forget Password?',
                    style: TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                ),
                CustomButton(text: "Login"),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Don't have an account? ",
                          style: TextStyle(color: Colors.white54, fontSize: 12),
                        ),
                        TextSpan(
                          text: "Sign Up",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 95, 175, 241),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
