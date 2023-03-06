import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_model.dart';
import '../helpers/firebase_helper.dart';

final firebaseControllerProvider = Provider((ref) {
  final firebaseHelper = ref.watch(firebaseHelperProvider);
  return AuthController(firebaseHelper: firebaseHelper, ref: ref);
});

final userDataProvider = FutureProvider((ref) {
  final authController = ref.watch(firebaseControllerProvider);
  return authController.getUserData();
});

class AuthController {
  final FirebaseHelper firebaseHelper;
  final ProviderRef ref;

  AuthController({
    required this.firebaseHelper,
    required this.ref,
  });

  void saveProfileAvatar(BuildContext context, File? profileAvatar) {
    firebaseHelper.saveProfileAvatar(
        context: context, profileAvatar: profileAvatar, ref: ref);
  }

  Stream<UserModel> userDataById(String userId) {
    return firebaseHelper.userDataById(userId);
  }

  Future<UserModel?> getUserData() async {
    UserModel? user = await firebaseHelper.getCurrentUserData();
    return user;
  }

  sendMessage(
      String messageText, UserModel user, TextEditingController controller) {
    try {
      firebaseHelper.sendMessage(messageText, user);
      controller.clear();
    } catch (e) {
      log(e.toString());
    }
  }

  getUserEmail() {
    try {
      return firebaseHelper.getUserEmail();
    } catch (e) {
      log(e.toString());
    }
  }

  saveUsername(String username, BuildContext context) {
    firebaseHelper.saveUsername(username: username, context: context);
  }

  void signIn(TextEditingController email, TextEditingController password,
      BuildContext context) {
    firebaseHelper.signIn(email, password, context);
  }

  void signUp(TextEditingController email, TextEditingController password,
      BuildContext context) {
    firebaseHelper.signUp(email, password, context, ref);
  }

  void signOut() {
    firebaseHelper.signOut();
  }

  Future<UserModel?> getCurrentUserData() {
    return firebaseHelper.getCurrentUserData();
  }
}
