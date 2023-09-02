import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../allConstants/all_constants.dart';

class AppUser extends Equatable {
  final String id;
  final String photoUrl;
  final Map<String, List<String>> openSettings;
  final String displayName;
  final Timestamp? updateAt;
  final String whatNowMessage;
  final String talkroomId;
  final String chtattingWith;
  final String whatNow;
  final String fcmToken;
  final bool isGirl;
  const AppUser(
      {required this.id,
      required this.photoUrl,
      required this.displayName,
      this.updateAt = null,
      this.whatNowMessage = '',
      required this.openSettings,
      required this.talkroomId,
      required this.chtattingWith,
      required this.whatNow,
      required this.fcmToken,
      required this.isGirl});

  // AppUser copyWith({
  //   String? id,
  //   String? photoUrl,
  //   String? nickname,
  //   String? updateAt,
  //   String? email,
  //   String? talkroomId,
  //   String? partnerUid,
  //   WhatNow? whatNow,
  //   String? fsmToken,
  // }) =>
  //     AppUser(
  //       id: id ?? this.id,
  //       photoUrl: photoUrl ?? this.photoUrl,
  //       displayName: nickname ?? displayName,
  //       updateAt: updateAt ?? this.updateAt,
  //       whatNowMessage: email ?? whatNowMessage,
  //       talkroomId: talkroomId ?? this.talkroomId,
  //       partnerUid: partnerUid ?? this.partnerUid,
  //       whatNow: whatNow ?? this.whatNow,
  //       fcmToken: fsmToken ?? this.fcmToken,
  //     );

  Map<String, dynamic> toJson() => {
        Consts.id: id,
        Consts.displayName: displayName,
        Consts.photoUrl: photoUrl,
        Consts.updateAt: updateAt,
        'openSettings': openSettings,
        'whatNowMessage': whatNowMessage,
        Consts.talkroomId: talkroomId,
        'chattingWith': chtattingWith,
        Consts.whatNow: whatNow,
        'fcmToken': fcmToken,
        'isGirl': isGirl,
      };
  factory AppUser.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final map = snapshot.data()!;
    Map<String, dynamic> rawOpenSettings = map['openSettings'] ??
        {
          "defaut": [""]
        }; // これがあなたが取得したデータです。
    Map<String, List<String>> openSettings = Map.from(rawOpenSettings)
        .map((key, value) => MapEntry(key, List<String>.from(value)));

    //     String photoUrl = "";
    // String nickname = "";
    // Timestamp? updateAt = null;
    // String whatNowMessage = "";
    // String talkroomId = "";
    // String chattingWith = '';
    // String whatNow = '';
    // String fcmToken = '';
    // bool isGirl = true;
    // try {
    //   final data = snapshot.data();
    //   photoUrl = snapshot.get(Consts.photoUrl);
    //   nickname = snapshot.get(Consts.displayName);
    //   if()
    //   updateAt = snapshot.data()[Consts.updateAt] ?? '';
    //   whatNowMessage = snapshot.get('whatNowMessage');
    //   talkroomId = snapshot.get(Consts.talkroomId);
    //   chattingWith = snapshot.get(chattingWith);
    //   whatNow = snapshot.get(Consts.whatNow);
    //   fcmToken = snapshot.get('fcmToken');
    //   isGirl = snapshot.get('isGirl');
    // } catch (e) {
    //   if (kDebugMode) {
    //     print(e);
    //   }
    // }

    return AppUser(
      id: snapshot.id,
      photoUrl: map[Consts.photoUrl] ?? 'Girl',
      displayName: map[Consts.displayName] ?? '',
      updateAt: map[Consts.updateAt],
      openSettings: openSettings,
      whatNowMessage: map['whatNowMessage'] ?? '',
      talkroomId: map[Consts.talkroomId] ?? '',
      chtattingWith: map[Consts.chattingWith] ?? 'P18KIdVBUqdcqVGyJt6moTLoONf2',
      whatNow: map[Consts.whatNow] ?? '',
      fcmToken: map['fcmToken'] ?? '',
      isGirl: map['isGirl'] ?? true,
    );
  }
  @override
  // TODO: implement props
  List<Object?> get props =>
      [id, photoUrl, displayName, updateAt, whatNowMessage, talkroomId];
}
