import 'dart:developer' show log;
import 'dart:io';

import 'package:chat_app/model/user_data.dart';
import 'package:chat_app/services/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth, FirebaseAuthException, User;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view/screens/home_screen.dart';

final firebaseHelperProvider = Provider(
  (ref) => FirebaseHelper(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  ),
);

class FirebaseHelper {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  FirebaseHelper({
    required this.auth,
    required this.firestore,
  });

  void signOut() => FirebaseAuth.instance.signOut();

  void signIn(
      TextEditingController email, TextEditingController password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);

      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          log('User is currently signed out!');
        } else {
          Get.off(() => const HomeScreen());
          log('User is signed in!');
        }
      });
    } on FirebaseAuthException catch (e) {
      log(e.code);
    }
  }

  void createUser(
      TextEditingController email, TextEditingController password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text, password: password.text);
      log("was created");
      signIn(email, password);
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          log('User is currently signed out!');
        } else {
          Get.off(() => const HomeScreen());
          log('User is signed in!');
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void saveData(
      {required String username,
      required File? profileAvatar,
      required BuildContext context,
      required ProviderRef ref}) async {
    try {
      String uid = auth.currentUser!.uid;
      String avatarUrl =
          'https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png';

      if (profileAvatar != null) {
        avatarUrl = await ref
            .read(commonFirebaseStorageProvider)
            .storeFile("profileAvatar/$uid", profileAvatar);
      }

      var user = UserModel(
          name: username, uid: uid, profileAvatar: avatarUrl, isOnline: true);

      await firestore.collection('users').doc(uid).set(user.toMap());
    } catch (e) {
      log(e.toString());
    }
  }

  Stream<UserModel> userData(String userId) {
    return firestore.collection('users').doc(userId).snapshots().map(
          (event) => UserModel.fromMap(
            event.data()!,
          ),
        );
  }

  void setUserState(bool isOnline) async {
    await firestore.collection('users').doc(auth.currentUser!.uid).update({
      'isOnline': isOnline,
    });
  }

  Future<UserModel?> getCurrentUserData() async {
    var userData =
        await firestore.collection('users').doc(auth.currentUser?.uid).get();

    UserModel? user;
    if (userData.data() != null) {
      user = UserModel.fromMap(userData.data()!);
    }
    return user;
  }
}
