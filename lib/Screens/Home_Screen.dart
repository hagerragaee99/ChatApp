import 'package:cubitproject/Managers/home_cubit/home_cubit.dart';
import 'package:cubitproject/Managers/home_cubit/home_state.dart';
import 'package:cubitproject/Screens/Chat_Screen.dart';
import 'package:cubitproject/Screens/Login_Screen.dart';
import 'package:cubitproject/Services/user_Service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  User currentUser;
  HomeScreen({super.key, required this.currentUser});

  static const String screenRoute = "Home_Screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserService userService = UserService();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[800],
          shape: const Border.symmetric(
            horizontal: BorderSide(
              width: 1,
              color: Color.fromARGB(255, 95, 175, 241),
            ),
            vertical: BorderSide(
              width: 1,
              color: Color.fromARGB(255, 33, 33, 33),
            ),
          ),
          title: Row(
            children: [
              Image.asset('images/icons8-chat-room-100.png', width: 30),
              const SizedBox(width: 10),
              const Text(
                'Chat App',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),

              IconButton(
                onPressed: () {
                  userService.signOut();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                icon: const Icon(
                  Icons.logout,
                  color: Color.fromARGB(255, 95, 175, 241),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.grey[900],

        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is HomeFailure) {
              return Center(child: Text(state.errorMessage));
            }

            if (state is HomeFetchedUsers) {
              return ListView.builder(
                itemCount: state.users.length,
                itemBuilder: (context, index) {
                  var user = state.users[index];

                  return InkWell(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(receiverUser: user),
                        ),
                      );
                    },

                    child: Card(
                      color: Colors.grey[800],
                      margin: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 5,
                      ),

                      child: Padding(
                        padding: const EdgeInsets.all(8.0),

                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.blue[200],

                              child: Text(
                                user.username[0].toUpperCase(),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),

                            const SizedBox(width: 10),

                            Text(
                              user.username,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
