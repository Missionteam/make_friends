import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../allConstants/all_constants.dart';
import '../models/user.dart';
import 'auth_provider.dart';
import 'firebase_provider.dart';

final appUsersReferenceProvider = Provider<CollectionReference<AppUser>>((ref) {
  final userReference = ref.read(firestoreProvider).collection(Consts.users);

  return userReference.withConverter<AppUser>(
    fromFirestore: ((snapshot, _) {
      return AppUser.fromFirestore(snapshot);
    }),
    toFirestore: ((value, _) {
      return value.toJson();
    }),
  );
});

final currentAppUserDocRefProvider =
    Provider<DocumentReference<AppUser>>((ref) {
  final uid = ref.watch(uidProvider);

  final appUsersReference = ref.watch(appUsersReferenceProvider);

  return appUsersReference.doc(uid);
});
final currentAppUserDocSetter = FutureProvider((ref) async {
  final appUserReference = ref.watch(currentAppUserDocRefProvider);
  final appUserDoc = await ref.watch(currentAppUserDocRefProvider).get();
  final uid = ref.watch(uidProvider);

  if (appUserDoc.exists == false) {
    final newUser = AppUser(
        id: uid!,
        photoUrl: 'Girl',
        displayName: 'かな',
        updateAt: null,
        whatNowMessage: '',
        talkroomId: uid,
        chtattingWith: 'P18KIdVBUqdcqVGyJt6moTLoONf2',
        whatNow: 'SleepGirl1.png',
        fcmToken: '',
        isGirl: true);
    appUserReference.set(newUser);
  }
});

final uidUserDocProvider = StreamProvider.family((ref, String uid) {
  final usersRef = ref.watch(appUsersReferenceProvider);
  final userDoc = usersRef.doc(uid).snapshots();
  final appUsersReference = ref.watch(currentAppUserDocRefProvider);
  if (userDoc.isEmpty == true) return appUsersReference.snapshots();
  return userDoc;
});

final currentAppUserDocProvider =
    StreamProvider<DocumentSnapshot<AppUser>>((ref) {
  final setter = ref.watch(currentAppUserDocSetter).value;
  final appUsersReference = ref.watch(currentAppUserDocRefProvider);

  return appUsersReference.snapshots();
});

final currentUserProvider = Provider<AppUser?>((ref) {
  final data = ref.watch(currentAppUserDocProvider).value?.data();
  return data;
});

final partnerUserDocRefProvider = Provider<DocumentReference<AppUser>>((ref) {
  final currentUserDoc = ref.watch(currentAppUserDocProvider).value;
  final String partnerUid =
      currentUserDoc?.get('chattingWith') ?? 'P18KIdVBUqdcqVGyJt6moTLoONf2';
  final appUsersReference = ref.watch(appUsersReferenceProvider);
  return appUsersReference.doc(partnerUid);
});

final partnerUserDocProvider = StreamProvider((ref) {
  final currentUserDoc = ref.watch(currentAppUserDocProvider).value;
  final partnerUid =
      currentUserDoc?.get('chattingWith') ?? 'P18KIdVBUqdcqVGyJt6moTLoONf2';
  final appUserReference = ref.watch(appUsersReferenceProvider);
  return appUserReference.doc(partnerUid).snapshots();
});

// final EngageStampNameProvider = StreamProvider<String>((ref) {
//   final currentAppUserDoc = ref.watch(currentAppUserDocProvider).value;
//   final Stream<String> stampname =
//       currentAppUserDoc?.get('stamp') ?? 'NoStamp.png';
//   return stampname;
// });

// final EngageStampNameProvider = FutureProvider<String?>((ref) {
//   final currentAppUserDoc = ref.watch(currentAppUserDocProvider).value;
//   return currentAppUserDoc?.get('stamp');
// });

// final EngageStampProvider = Provider((ref) {
//   final stampnamevalue = ref.watch(EngageStampNameProvider).value;
//   final stampname = stampnamevalue ?? 'NoStamp.png';
//   return Image.asset('images/${stampname}');
// });

final userWhatNowNameProvider = FutureProvider<String?>((ref) {
  final currentAppUserDoc = ref.watch(currentAppUserDocProvider).value;
  return currentAppUserDoc?.get('whatNow');
});

final userWhatNowProvider = Provider((ref) {
  final stampnamevalue = ref.watch(userWhatNowNameProvider).value;
  final stampname = stampnamevalue ?? 'NoStamp.png';
  return Image.asset('images/whatNowStamp/$stampname');
});

final currentUserfcmTokenProvider = FutureProvider<String?>((ref) {
  final currentAppUserDoc = ref.watch(currentAppUserDocProvider).value;
  return currentAppUserDoc?.get('fcmToken');
});
final userWhatNowMessageProvider = FutureProvider<String?>((ref) {
  final currentAppUserDoc = ref.watch(currentAppUserDocProvider).value;
  final doc = currentAppUserDoc?.data();

  final whatNowMessage = currentAppUserDoc?.data()?.whatNowMessage ?? '';
  return whatNowMessage;
});
final userupdateAtProvider = FutureProvider((ref) {
  final currentAppUserDoc = ref.watch(currentAppUserDocProvider).value;
  final updateAt = currentAppUserDoc?.data()?.updateAt;
  return updateAt;
});

final PartnerfcmTokenProvider = FutureProvider<String?>((ref) {
  final partnerAppUserDoc = ref.watch(partnerUserDocProvider).value;
  return partnerAppUserDoc?.get('fcmToken');
});

final partnerWhatNowNameProvider = FutureProvider<String?>((ref) {
  final partnerAppUserDoc = ref.watch(partnerUserDocProvider).value;
  return partnerAppUserDoc?.get('whatNow');
});

final partnerWhatNowProvider = Provider((ref) {
  final stampnamevalue = ref.watch(partnerWhatNowNameProvider).value;
  final stampname = stampnamevalue ?? 'NoStamp.png';
  return Image.asset('images/whatNowStamp/$stampname');
});
final partnerWhatNowMessageProvider = FutureProvider<String?>((ref) {
  final partnerAppUserDoc = ref.watch(partnerUserDocProvider).value;
  final whatNowMessage = partnerAppUserDoc?.data()?.whatNowMessage ?? '';
  return whatNowMessage;
});
final partnerUpdateAtProvider = FutureProvider((ref) {
  final currentAppUserDoc = ref.watch(currentAppUserDocProvider).value;
  final updateAt = currentAppUserDoc?.data()?.updateAt;
  return updateAt;
});

final whatNowNameProvider = Provider.family((ref, bool isUser) {
  final userWhatNowName =
      ref.watch(userWhatNowNameProvider).value ?? 'NoStamp.png';
  final partnerWhatNowName =
      ref.watch(partnerWhatNowNameProvider).value ?? 'NoStamp.png';

  return (isUser == true) ? userWhatNowName : partnerWhatNowName;
});

final isGirlProvider = Provider<bool>((ref) {
  final bool isGirl =
      ref.watch(currentAppUserDocProvider).value?.get('isGirl') ?? true;
  return isGirl;
});

final whatNowDisplayNameProvider = Provider.family((ref, bool isUser) {
  final userDoc = ref.watch(currentAppUserDocProvider).value;
  final userName = userDoc?.get('displayName') ?? '';
  final partnerDoc = ref.watch(partnerUserDocProvider).value;
  final String partnerName = partnerDoc?.get('displayName') ?? '';

  return (isUser == true) ? userName : partnerName;
});

final whatNowMessageProvider = Provider.family((ref, bool isUser) {
  final userWhatNowMessage = ref.watch(userWhatNowMessageProvider).value ?? '';
  final partnerWhatNowMessage =
      ref.watch(partnerWhatNowMessageProvider).value ?? '';
  return (isUser == true) ? userWhatNowMessage : partnerWhatNowMessage;
});
final whatNowUpdateAtProvider = Provider.family((ref, bool isUser) {
  final userTimestamp = ref.watch(userupdateAtProvider).value?.toDate();
  final userUpdateAt = (userTimestamp != null)
      ? DateFormat('MM/dd HH:mm').format(userTimestamp).toString()
      : '';
  final partnerTimestamp = ref.watch(partnerUpdateAtProvider).value?.toDate();
  final partnerUpdateAt = (partnerTimestamp != null)
      ? DateFormat('MM/dd HH:mm').format(partnerTimestamp).toString()
      : '';
  return (isUser == true) ? userUpdateAt : partnerUpdateAt;
});

@immutable
class isVisible {
  const isVisible({required this.istrue});
  final bool istrue;
}

class isVisibleNotifier extends StateNotifier<isVisible> {
  isVisibleNotifier() : super(const isVisible(istrue: true));

  void setisVisible(value) {
    state = isVisible(istrue: value);
  }
}

final isVisibleProvider =
    StateNotifierProvider<isVisibleNotifier, isVisible>((ref) {
  return isVisibleNotifier();
});
