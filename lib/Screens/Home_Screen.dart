import 'package:cubitproject/Models/UserModel.dart';
import 'package:cubitproject/Screens/Chat_Screen.dart';
import 'package:cubitproject/Screens/Login_Screen.dart';
import 'package:cubitproject/Services/user_Service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class HomeScreen extends StatefulWidget {
  User currentUser;
  HomeScreen({super.key, required this.currentUser});

  static const String screenRoute = "Home_Screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserService userService = UserService();
  List<UserModel> users = [];

  bool _saving = false;

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  Future<void> getUsers() async {
    final fetchedUsers = await userService.getUsers();

    if (fetchedUsers != null) {
      users = fetchedUsers
          .where((user) => user.uid != widget.currentUser.uid)
          .toList();

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

      body: ModalProgressHUD(
        inAsyncCall: _saving,
        child: ListView(
          children: [
            for (var user in users)
              InkWell(
                onTap: () async {
                  setState(() {
                    _saving = true;
                  });

                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(receiverUser: user),
                    ),
                  );

                  setState(() {
                    _saving = false;
                  });
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
              ),
          ],
        ),
      ),
    );
  }
}
