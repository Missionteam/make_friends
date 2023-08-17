// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../allConstants/firestore_constants.dart';
import 'post.dart';

final authenticationProvider = Provider((ref) {
  return Authentication(ref);
});

class Authentication {
  // For Authentication related functions you need an instance of FirebaseAuth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  final Ref ref;

  Authentication(this.ref);

  //  This getter will be returning a Stream of User object.
  //  It will be used to check if the user is logged in or not.
  Stream<User?> get authStateChange {
    return _auth.authStateChanges();
  }

  // Now This Class Contains 3 Functions currently
  // 1. signInWithGoogle
  // 2. signOut
  // 3. signInwithEmailAndPassword

  //  All these functions are async because this involves a future.
  //  if async keyword is not used, it will throw an error.
  //  to know more about futures, check out the documentation.
  //  https://dart.dev/codelabs/async-await
  //  Read this to know more about futures.
  //  Trust me it will really clear all your concepts about futures

  //  SignIn the user Google
  Future<void> signInWithGoogle(BuildContext context) async {
    // Trigger the authentication flow
    GoogleSignInAccount? googleUser =
        await GoogleSignIn(scopes: ['profile', 'email']).signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    User? firebaseUser = (await _auth.signInWithCredential(credential)).user;
    final _prefs = await SharedPreferences.getInstance();
    if (firebaseUser != null) {
      final QuerySnapshot result = await firestore
          .collection(Consts.users)
          .where(Consts.id, isEqualTo: firebaseUser.uid)
          .get();
      final List<DocumentSnapshot> document = result.docs;
      if (document.isEmpty) {
        DocumentReference userDocRef =
            firestore.collection(Consts.users).doc(firebaseUser.uid);

        ///DocUser
        userDocRef.set({
          Consts.displayName: firebaseUser.displayName,
          Consts.photoUrl: firebaseUser.photoURL,
          Consts.id: firebaseUser.uid,
          "createdAt: ": DateTime.now().millisecondsSinceEpoch.toString(),
          Consts.chattingWith: 'P18KIdVBUqdcqVGyJt6moTLoONf2',
          Consts.talkroomId: firebaseUser.uid,
          'whatNow': 'SleepGirl1',
          'fcmToken': '',
          'isWomen': true,
        });

        ///CollectionPost
        final initpost = Post(
            text: '',
            createdAt: Timestamp.now(),
            posterName: '',
            posterImageUrl: '',
            posterId: '',
            stamps: '',
            reference: userDocRef.collection(Consts.posts).doc('init'));

        final initDoc = userDocRef.collection(Consts.posts).doc('init');
        initDoc.set(initpost.toJson());
        //initDoc.delete();

        ///prefs
        User? currentUser = firebaseUser;
        await _prefs.setString(Consts.id, currentUser.uid);
        await _prefs.setString(
            Consts.displayName, currentUser.displayName ?? "");
        await _prefs.setString(Consts.photoUrl, currentUser.photoURL ?? "");

        await _prefs.setString(Consts.talkroomId, currentUser.uid);
      } else {
        DocumentSnapshot documentSnapshot = document[0];
        // AppUser appUser = AppUser.fromFirestore(documentSnapshot);
        // await _prefs.setString(Consts.id, appUser.id);
        // await _prefs.setString(Consts.displayName, appUser.displayName);
        // await _prefs.setString('whatNowMessage', appUser.whatNowMessage);

        // await _prefs.setString(Consts.talkroomId, appUser.talkroomId);
      }
    } else {
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Error Occured'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text("OK"))
          ],
        ),
      );
    }
  }

  Future<void> signInWithMail(
      BuildContext context, String email, String password) async {
    final _prefs = await SharedPreferences.getInstance();

    final User? firebaseUser = (await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password))
        .user;

    if (firebaseUser != null) {
      print("ユーザ登録しました ${firebaseUser.email} , ${firebaseUser.uid}");
      final QuerySnapshot result = await firestore
          .collection(Consts.users)
          .where(Consts.id, isEqualTo: firebaseUser.uid)
          .get();
      final List<DocumentSnapshot> document = result.docs;
      if (document.isEmpty) {
        DocumentReference userDocRef =
            firestore.collection(Consts.users).doc(firebaseUser.uid);

        ///DocUser
        userDocRef.set({
          Consts.displayName: 'かな',
          Consts.photoUrl: 'Girl',
          Consts.id: firebaseUser.uid,
          "createdAt: ": DateTime.now().millisecondsSinceEpoch.toString(),
          Consts.chattingWith: 'P18KIdVBUqdcqVGyJt6moTLoONf2',
          Consts.talkroomId: firebaseUser.uid,
          'whatNow': 'SleepGirl1.png',
          'fcmToken': '',
          'isGirl': true,
        });

        ///CollectionPost
        final initpost = Post(
            text: '',
            createdAt: Timestamp.now(),
            posterName: '',
            posterImageUrl: '',
            posterId: '',
            stamps: '',
            reference: userDocRef.collection(Consts.posts).doc('init'));

        final initDoc = userDocRef.collection(Consts.posts).doc('init');
        initDoc.set(initpost.toJson());
        //initDoc.delete();

        ///prefs
        User? currentUser = firebaseUser;
        await _prefs.setString(Consts.id, currentUser.uid);
        await _prefs.setString(
            Consts.displayName, currentUser.displayName ?? "");
        await _prefs.setString(Consts.photoUrl, currentUser.photoURL ?? "");

        await _prefs.setString(Consts.talkroomId, currentUser.uid);
      } else {
        DocumentSnapshot documentSnapshot = document[0];
        // AppUser appUser = AppUser.fromFirestore(documentSnapshot);
        // await _prefs.setString(Consts.id, appUser.id);
        // await _prefs.setString(Consts.displayName, appUser.displayName);
        // await _prefs.setString('whatNowMessage', appUser.whatNowMessage);

        // await _prefs.setString(Consts.talkroomId, appUser.talkroomId);
      }
    } else {
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Error Occured'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text("OK"))
          ],
        ),
      );
    }
  }

  //  SignOut the current user
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
