import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../allConstants/all_constants.dart';
import '../models/post.dart';
import 'auth_provider.dart';
import 'firebase_provider.dart';

///postReferenceProviderが提供する
///ReferenceにあるPostを取得するプロバイダー
final postsProvider = StreamProvider((ref) {
  final postsReference = ref.watch(postsReferenceProvider);
  return postsReference.orderBy('createdAt', descending: true).snapshots();
});

final postsReverseProvider = StreamProvider.family((ref, String roomId) {
  final postsReference = ref.watch(postsReferenceProvider);
  final uid = ref.watch(uidProvider);
  return postsReference
      .where('roomId', isEqualTo: roomId)
      .where('posterId', isEqualTo: uid)
      .orderBy('createdAt', descending: true)
      .snapshots();
});

///現在のtalkroom直下のpostのReferenceを取得するプロバイダー
final postsReferenceProvider = Provider<CollectionReference<Post>>((ref) {
  final firestore = ref.read(firestoreProvider);
  return firestore.collection('posts').withConverter<Post>(
        fromFirestore: ((snapshot, _) => Post.fromFirestore(snapshot)),
        toFirestore: ((value, _) => value.toJson()),
      );
});

final reviewPostsReferenceProvider = Provider<CollectionReference<Post>>((ref) {
  ///talkroomReferenceが取得中のときは、空のコレクションを渡す。

  return FirebaseFirestore.instance
      .collection('talkrooms')
      .doc('zrg4iMBJbadqTComgGpGMtdortQ2')
      .collection(Consts.posts)
      .withConverter<Post>(
        fromFirestore: ((snapshot, _) => Post.fromFirestore(snapshot)),
        toFirestore: ((value, _) => value.toJson()),
      );
});

final officialPostsReferenceProvider =
    Provider<CollectionReference<Post>>((ref) {
  final firestore = ref.read(firestoreProvider);
  return firestore.collection('official').withConverter<Post>(
        fromFirestore: ((snapshot, _) => Post.fromFirestore(snapshot)),
        toFirestore: ((value, _) => value.toJson()),
      );
});
final officialPostsProvider = StreamProvider((ref) {
  final postsReference = ref.watch(officialPostsReferenceProvider);
  return postsReference.orderBy('createdAt', descending: true).snapshots();
});
