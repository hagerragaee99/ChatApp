// ignore_for_file: avoid_print, use_build_context_synchronously, unnecessary_null_comparison, must_be_immutable

import 'package:cubitproject/Managers/login_cubit/login_cubit.dart';
import 'package:cubitproject/Managers/login_cubit/login_state.dart';
import 'package:cubitproject/Screens/Home_Screen.dart';
import 'package:cubitproject/Screens/Register_Screen.dart';
import 'package:cubitproject/Services/user_Service.dart';
import 'package:cubitproject/Widgets/Custom_Button.dart';
import 'package:cubitproject/Widgets/Custom_InkWellTextSpan.dart';
import 'package:cubitproject/Widgets/Custom_TextFormField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  static const String screenRoute = "Login_Screen";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String emailController = '';
  String passwordController = '';

  UserService userService = UserService();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
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
                  CustomTextformfield(
                    hintText: 'Enter Your Email',
                    onChanged: (value) {
                      emailController = value;
                    },
                  ),
                  CustomTextformfield(
                    hintText: 'Enter Your Password',
                    onChanged: (value) {
                      passwordController = value;
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Forget Password?',
                      style: TextStyle(color: Colors.white54, fontSize: 12),
                    ),
                  ),
                  BlocConsumer<LoginCubit, LoginState>(
                    listener: (context, state) {
                      if (state is LoginSuccess) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(
                              currentUser: userService.getCurrentUser(),
                            ),
                          ),
                          (route) => false,
                        );
                      } else if (state is LoginFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.errorMessage)),
                        );
                      }
                    },

                    builder: (context, state) {
                      return state is LoginLoading
                          ? Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 1,
                              ),
                            )
                          : CustomButton(
                              text: "Login",
                              onPressed: () {
                                context.read<LoginCubit>().login(
                                  emailController,
                                  passwordController,
                                );
                              },
                            );
                    },
                  ),
                  CustomInkwelltextspan(
                    screenRoute: RegisterScreen.screenRoute,
                    text1: "Don't have an account? ",
                    text2: "Sign Up",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
