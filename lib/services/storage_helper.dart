import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final commonFirebaseStorageProvider = Provider(
  (ref) => CommonFirebaseStorage(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
    firebaseStorage: FirebaseStorage.instance,
  ),
);

class CommonFirebaseStorage {
  final FirebaseStorage firebaseStorage;
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  CommonFirebaseStorage(
      {required this.firebaseStorage,
      required this.auth,
      required this.firestore});

  Future<String> storeFile(String ref, File file) async {
    UploadTask uploadTask = firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
