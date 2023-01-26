import 'package:flutter/foundation.dart';

@immutable
class UserModel {
  final String name;
  final String uid;
  final String profileAvatar;
  final bool isOnline;

  const UserModel({
    required this.name,
    required this.uid,
    required this.profileAvatar,
    required this.isOnline,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uid': uid,
      'profilePic': profileAvatar,
      'isOnline': isOnline,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      uid: map['uid'] ?? '',
      profileAvatar: map['profilePic'] ?? '',
      isOnline: map['isOnline'] ?? false,
    );
  }
}
