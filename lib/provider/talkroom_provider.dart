import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../allConstants/all_Constants.dart';
import '../models/post.dart';
import '../models/user.dart';
import 'auth_provider.dart';
import 'firebase_provider.dart';
import 'users_provider.dart';

///ユーザーはログインしてるし、TalkroomIdはなかったら作る。//talkroomidはnullの場合がある。
final talkroomIdProvider = FutureProvider<String>((ref) async {
  final firestore = ref.read(firestoreProvider);
  final String? uid = ref.watch(uidProvider);

  final appUserRef = ref.watch(currentAppUserDocRefProvider);

  if (uid == null) {
    throw Exception('ログインしていません。');
  }
  final appUserDoc = await ref.watch(currentAppUserDocRefProvider).get();

  String getTalkroomId(String? talkroomId, DocumentSnapshot<AppUser> UserDoc) {
    if (talkroomId != null) {
      return UserDoc.get(Consts.talkroomId)!;
    } else {
      appUserRef.update({Consts.talkroomId: uid});
      return appUserDoc.get(Consts.talkroomId)!;
    }
  }

  if (appUserDoc.exists) {
    final String? talkroomId = appUserDoc.get(Consts.talkroomId);
    return getTalkroomId(talkroomId, appUserDoc);
  }

  ///ユーザーDocがないときはDocを作成後talkroomIdを取得。
  else {
    final newUser = AppUser(
        id: uid,
        photoUrl: 'Girl',
        displayName: 'かな',
        updateAt: null,
        whatNowMessage: '',
        talkroomId: uid,
        chtattingWith: 'P18KIdVBUqdcqVGyJt6moTLoONf2',
        whatNow: 'SleepGirl1.png',
        fcmToken: '',
        isGirl: true);
    await appUserRef.set(newUser);
    final userReDocumentSnapshot =
        await ref.watch(currentAppUserDocRefProvider).get();
    final String talkroomId = userReDocumentSnapshot.get(Consts.talkroomId);
    return getTalkroomId(talkroomId, userReDocumentSnapshot);
  }
});

final talkroomDocProvider = FutureProvider((ref) async {
  final firestore = ref.read(firestoreProvider);
  final String? talkroomId = ref.watch(talkroomIdProvider).value;
  final tallkroomRef = ref.watch(talkroomReferenceProvider).value;

  if (talkroomId == null || tallkroomRef == null) {
    return null;
  }
  final talkDocroomRef = firestore.collection(Consts.talkrooms).doc(talkroomId);
  final talkroomDoc = await talkDocroomRef.get();

  return talkroomDoc;
});

final talkroomReferenceProvider = FutureProvider((ref) async {
  final firestore = ref.read(firestoreProvider);
  final uid = ref.watch(uidProvider);
  final String? talkroomId = ref.watch(talkroomIdProvider).value;
  final talkDocroomRef = firestore.collection(Consts.talkrooms).doc(talkroomId);
  final talkroomDoc = await talkDocroomRef.get();
  // final partner = ref.watch(partnerUserDocProvider).value;

  // final partnerUid = partner?.id ?? 'P18KIdVBUqdcqVGyJt6moTLoONf2';
  final partnerUid = 'P18KIdVBUqdcqVGyJt6moTLoONf2';
  if (talkroomId == null) {
    return null;
  }

  ///talkroomDocが存在しないときに、talkroomを生成。
  void talkroomsetter() {
    talkDocroomRef.set({
      'users': [uid],
      'lastRoomIndex': 1,
      'version': 0
    });
    talkDocroomRef.collection(Consts.posts).doc();
    final initpost = Post(
        text: '',
        createdAt: Timestamp.now(),
        posterName: '運営より',
        posterImageUrl: 'Boy',
        posterId: uid ?? '',
        stamps: '😌',
        reference: talkDocroomRef.collection(Consts.posts).doc('init'));
    final initPostDoc = talkDocroomRef.collection(Consts.posts).doc('init');
    initPostDoc.set(initpost.toJson());
  }

  if (talkroomDoc.exists) {
    final initRoomRef = talkDocroomRef.collection('rooms').doc('init');

    return talkDocroomRef;
  } else {
    print('tester');
    talkroomsetter();
    final retalkDocroomRef =
        await firestore.collection(Consts.talkrooms).doc(talkroomId);
    return retalkDocroomRef;
  }
});

final lastRoomIndexProvider = FutureProvider<int>((ref) async {
  final currentTalkroomSnapshot =
      await ref.watch(talkroomReferenceProvider).value?.get();
  final int lastRoomIndex = currentTalkroomSnapshot?.get('lastRoomIndex') ?? 1;

  return lastRoomIndex;
});
