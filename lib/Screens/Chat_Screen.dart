// ignore_for_file: use_build_context_synchronously, file_names

import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cubitproject/Models/UserModel.dart';
import 'package:cubitproject/Services/chat_Service.dart';
import 'package:cubitproject/Services/user_Service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  static const String screenRoute = "Chat_Screen";

  final UserModel receiverUser;
  ChatScreen({super.key, required this.receiverUser});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatService _chatService = ChatService();

  late User signedInUser;

  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    signedInUser = UserService().getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
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
            CircleAvatar(
              radius: 17,
              backgroundColor: Colors.blue[200],
              child: Text(
                widget.receiverUser.username[0].toUpperCase(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              widget.receiverUser.username,
              style: const TextStyle(fontSize: 17, color: Colors.white),
            ),
          ],
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: _chatService.getMessagesStream(
                    signedInUser.uid,
                    widget.receiverUser.uid,
                  ),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final messages = snapshot.data!.docs;

                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListView.builder(
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];

                          final isMe = message['senderId'] == signedInUser.uid;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 3.0),
                            child: Row(
                              mainAxisAlignment: isMe
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              children: [
                                BubbleSpecialThree(
                                  text: message['text'],
                                  color: isMe
                                      ? const Color.fromARGB(255, 95, 175, 241)
                                      : Colors.grey,
                                  tail: true,
                                  textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Type a message',
                        hintStyle: const TextStyle(
                          color: Colors.white54,
                          fontSize: 13,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            _chatService.sendMessage(
                              text: messageController.text,
                              senderId: signedInUser.uid,
                              receiverId: widget.receiverUser.uid,
                            );
                            messageController.clear();
                          },
                          icon: const Icon(
                            Icons.send,
                            color: Color.fromARGB(255, 95, 175, 241),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white54),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 95, 175, 241),
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
