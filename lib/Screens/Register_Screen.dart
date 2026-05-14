// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison, must_be_immutable
import 'package:cubitproject/Models/UserModel.dart';
import 'package:cubitproject/Screens/Home_Screen.dart';
import 'package:cubitproject/Services/user_Service.dart';
import 'package:cubitproject/Widgets/Custom_Button.dart';
import 'package:cubitproject/Widgets/Custom_InkWellTextSpan.dart';
import 'package:cubitproject/Widgets/Custom_TextFormField.dart';
import 'package:flutter/material.dart';
import 'package:cubitproject/Screens/Login_Screen.dart';
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
                      color: const Color.fromARGB(255, 95, 175, 241),
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
                    onPressed: () async {
                      setState(() {
                        _saving = true;
                      });
                      try {
                        final user = await userService
                            .registerWithEmailAndPassword(
                              emailController,
                              passwordController,
                            );

                        await userService.addUserToFirestore(
                          UserModel(
                            uid: user!.uid,
                            email: emailController,
                            username: usernameController,
                          ),
                        );
                        if (user != null) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  HomeScreen(currentUser: user),
                            ),
                            (route) => false,
                          );
                        }
                        setState(() {
                          _saving = false;
                        });
                      } catch (e) {
                        print(e);
                      }
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
  }
}
