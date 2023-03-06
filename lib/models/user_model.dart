import 'package:flutter/foundation.dart';

@immutable
class UserModel {
  final String username;
  final String uid;
  final String profileAvatar;

  const UserModel({
    required this.username,
    required this.uid,
    required this.profileAvatar,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'uid': uid,
      'profileAvatar': profileAvatar,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'] ?? '',
      uid: map['uid'] ?? '',
      profileAvatar: map['profileAvatar'] ?? '',
    );
  }
}
