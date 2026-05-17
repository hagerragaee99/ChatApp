// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison, must_be_immutable

import 'package:cubitproject/Managers/signup_cubit/signup_cubit.dart';
import 'package:cubitproject/Managers/signup_cubit/signup_state.dart';
import 'package:cubitproject/Screens/Home_Screen.dart';
import 'package:cubitproject/Services/user_Service.dart';
import 'package:cubitproject/Widgets/Custom_Button.dart';
import 'package:cubitproject/Widgets/Custom_InkWellTextSpan.dart';
import 'package:cubitproject/Widgets/Custom_TextFormField.dart';
import 'package:flutter/material.dart';
import 'package:cubitproject/Screens/Login_Screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterScreen extends StatefulWidget {
  static const String screenRoute = "Register_Screen";

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String emailController = '';
  String passwordController = '';
  String usernameController = '';
  String confirmPasswordController = '';

  bool _saving = false;

  UserService userService = UserService();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(),
      child: BlocConsumer<SignupCubit, SignupState>(
        listener: (context, state) {
          if (state is SignupLoading) {
            setState(() {
              _saving = true;
            });
          } else if (state is SignupFailure) {
            setState(() {
              _saving = false;
            });

            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
          } else if (state is SignupSuccess) {
            setState(() {
              _saving = false;
            });

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    HomeScreen(currentUser: userService.getCurrentUser()),
              ),
              (route) => false,
            );
          }
        },

        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.grey[900],
            body: ModalProgressHUD(
              inAsyncCall: _saving,
              child: Center(
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
                            color: Color.fromARGB(255, 95, 175, 241),
                          ),
                        ),

                        CustomTextformfield(
                          hintText: 'Enter Your Username',
                          onChanged: (value) {
                            usernameController = value;
                          },
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

                        CustomTextformfield(
                          hintText: 'Confirm Your Password',
                          onChanged: (value) {
                            confirmPasswordController = value;
                          },
                        ),

                        CustomButton(
                          text: "Register",
                          onPressed: () {
                            context.read<SignupCubit>().signup(
                              emailController,
                              passwordController,
                              usernameController,
                            );
                          },
                        ),

                        CustomInkwelltextspan(
                          screenRoute: LoginScreen.screenRoute,
                          text1: "Already have an account? ",
                          text2: "Login",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
