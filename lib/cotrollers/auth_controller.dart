import 'dart:io';

import 'package:chat_app/services/firebase_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/user_data.dart';

final authControllerProvider = Provider((ref) {
  final firebaseHelper = ref.watch(firebaseHelperProvider);
  return AuthController(firebaseHelper: firebaseHelper, ref: ref);
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
}
