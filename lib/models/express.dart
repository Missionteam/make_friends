import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:make_friends_app/models/expressItem.dart';

class Express extends ExpressItem {
  Express({
    required String express,
    required List<String> this.openUsers,
    required String this.uid,
    required String title,
    required String imageUrl,
    required DocumentReference this.reference,
  }) : super(
          title: title,
          imageUrl: imageUrl,
          express: express,
        );

  factory Express.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final map = snapshot.data()!;
    List<dynamic> rawOpenUsers =
        map['openSettings'] ?? [""]; // これがあなたが取得したデータです。
    List<String> openUsers = rawOpenUsers.cast<String>();
    return Express(
      express: map['express'],
      openUsers: openUsers,
      uid: map['uid'],
      title: map['title'],
      imageUrl: map['imageUrl'],
      reference: snapshot.reference,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'openUsers': openUsers,
      'uid': uid,
      'imageUrl': imageUrl,
      'express': express,
    };
  }

  final String uid;
  final DocumentReference reference;
  final List<String> openUsers;
}
