import 'dart:developer';
import 'dart:io';

import 'package:chat_app/model/user_model.dart';
import 'package:chat_app/services/storage_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

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
  FirebaseHelper({required this.auth, required this.firestore, this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection("groups");

  final String? uid;

  Stream<UserModel> userData(String userId) {
    return firestore.collection('users').doc(userId).snapshots().map(
          (event) => UserModel.fromMap(
            event.data()!,
          ),
        );
  }

  void firstSave({
    required String name,
    required File? profileAvatar,
    required ProviderRef ref,
    required BuildContext context,
  }) async {
    try {
      String uid = auth.currentUser!.uid;
      String photoUrl =
          'https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png';

      if (profileAvatar != null) {
        photoUrl = await ref.read(commonFirebaseStorageProvider).storeFile(
              'profileAvatar/$uid',
              profileAvatar,
            );
      }

      var user = UserModel(
        uid: uid,
        profileAvatar: photoUrl,
        username: '',
      );

      await firestore.collection('users').doc(uid).set(user.toMap());
    } catch (e) {
      log(e.toString());
    }
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

  Future<void> saveUsername(
      {required String username, required BuildContext context}) async {
    firestore
        .collection("users")
        .doc(auth.currentUser?.uid)
        .update({'username': username})
        .then((value) => log("Username changed to $username"))
        .catchError((err) => log(err.toString()));
  }

  Future<void> saveProfileAvatar({
    required File? profileAvatar,
    required ProviderRef ref,
    required BuildContext context,
  }) async {
    try {
      String uid = auth.currentUser!.uid;

      final String photoUrl =
          await ref.read(commonFirebaseStorageProvider).storeFile(
                'profileAvatar/$uid',
                profileAvatar!,
              );

      firestore
          .collection("users")
          .doc(auth.currentUser?.uid)
          .update({'profileAvatar': photoUrl})
          .then((value) => log("Username changed to $photoUrl"))
          .catchError((err) => log(err.toString()));
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> signIn(TextEditingController email,
      TextEditingController password, BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);

      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          log('User is currently signed out!');
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
            (route) => false,
          );
          log('User is signed in!');
        }
      });
    } on FirebaseAuthException catch (e) {
      log(e.code);
    }
  }

  Future<void> signUp(
      TextEditingController email,
      TextEditingController password,
      BuildContext context,
      ProviderRef ref) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text, password: password.text);
      log("was created");
      firstSave(
          name: email.text, profileAvatar: null, context: context, ref: ref);
      // ignore: use_build_context_synchronously
      signIn(email, password, context);
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

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
