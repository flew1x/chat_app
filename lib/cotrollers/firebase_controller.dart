import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/user_data.dart';
import '../services/firebase_helper.dart';

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

  void saveUserData(
      BuildContext context, String username, File? profileAvatar) {
    firebaseHelper.saveData(
        username: username,
        profileAvatar: profileAvatar,
        context: context,
        ref: ref);
  }

  Stream<UserModel> userDataById(String userId) {
    return firebaseHelper.userData(userId);
  }

  void setUserState(bool isOnline) {
    firebaseHelper.setUserState(isOnline);
  }

  Future<UserModel?> getUserData() async {
    UserModel? user = await firebaseHelper.getCurrentUserData();
    return user;
  }

  void signIn(TextEditingController email, TextEditingController password,
      BuildContext context) {
    firebaseHelper.signIn(email, password, context);
  }

  void signUp(TextEditingController email, TextEditingController password,
      BuildContext context) {
    firebaseHelper.signUp(email, password, context);
  }

  void signOut() {
    firebaseHelper.signOut();
  }

  Future<UserModel?> getCurrentUserData() {
    return firebaseHelper.getCurrentUserData();
  }
}
