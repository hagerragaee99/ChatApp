// ignore_for_file: invalid_return_type_for_catch_error, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cubitproject/Models/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;

  User getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        return user;
      }
    } catch (e) {
      print(e);
    }
    throw Exception("No user is currently signed in.");
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<User?> registerWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<User?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<UserModel>?> getUsers() async {
    try {
      final snapshot = await _fireStore.collection('users').get();

      return snapshot.docs.map((doc) => UserModel.fromMap(doc.data())).toList();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> addUserToFirestore(UserModel user) async {
    try {
      await _fireStore.collection('users').doc(user.uid).set({
        'username': user.username,
        'email': user.email,
        'uid': user.uid,
      });
    } catch (e) {
      print(e);
    }
  }
}
