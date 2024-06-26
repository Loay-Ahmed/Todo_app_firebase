import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<User?> signInWithEmail(String email, String pass) async {
    try {
      UserCredential result =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);
      User? user = result.user;
      return user;
    } catch (e) {
      return null;
    }
  }

  Future addUserDetails(User user, List<dynamic> tasks) async {
    try {
      String taskList = jsonEncode(tasks);
      await firestore.collection("tasks").doc(user.uid).set({
        'tasks': taskList,
      });
    } catch (e) {
      return null;
    }
  }

  Future<List<dynamic>> getUserDetails(User user) async {
    try {
      var json = await firestore.collection("tasks").doc(user.uid).get();
      List<dynamic> tasks = jsonDecode((json.data() as Map)['tasks']);
      return tasks;
    } catch (e) {
      return [];
    }
  }

  Future<User?> signUpWithEmail(String name, String email, String pass) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      User? user = result.user;
      if (user != null) addUserDetails(user, []);
      return user;
    } catch (e) {
      return null;
    }
  }

  Future resetPass(String email, BuildContext context) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<void> signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return;
    }
  }
}
