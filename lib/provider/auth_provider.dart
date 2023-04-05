import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/auth_model.dart';

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.read(authenticationProvider).authStateChange;
});

final fireBaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final uidProvider = Provider<String?>((ref) {
  final firebaseAuth = ref.read(fireBaseAuthProvider);
  return firebaseAuth.currentUser?.uid;
});
