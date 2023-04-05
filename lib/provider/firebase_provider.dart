import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firestoreProvider = Provider((ref) {
  return FirebaseFirestore.instance;
});

final fireStorageProvider = Provider((ref) {
  return FirebaseStorage.instance;
});
