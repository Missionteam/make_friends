import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  Post({
    required this.text,
    required this.roomId,
    required this.createdAt,
    required this.posterName,
    required this.posterImageUrl,
    required this.posterId,
    required this.reference,
    required this.stamps,
    this.id = '',
    this.replyCount = 0,
    this.imageUrl = '',
    this.imageLocalPath = '',
  });
  final String text;
  final String roomId;
  final Timestamp createdAt;
  final String posterName;
  final String posterImageUrl;
  final String posterId;
  final String? stamps;
  final String imageUrl;
  final String imageLocalPath;
  final String id;

  final DocumentReference reference;
  final int replyCount;
  factory Post.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final map = snapshot.data()!; // data() の中には Map 型のデータが入っています。
    // data()! この ! 記号は nullable な型を non-nullable として扱うよ！ という意味です。
    // data の中身はかならず入っているだろうという仮説のもと ! をつけています。
    // map データが得られているのでここからはいつもと同じです。
    return Post(
      text: map['text'],
      roomId: map['roomId'],
      createdAt: map['createdAt'],
      posterName: map['posterName'],
      posterImageUrl: map['posterImageUrl'],
      posterId: map['posterId'],
      stamps: map['stamps'],
      replyCount: map['replyCount'] ?? 0,
      imageUrl: map['imageUrl'] ?? '',
      imageLocalPath: map['imageLocalPath'] ?? '',
      id: map['id'] ?? '',
      reference:
          snapshot.reference, // 注意。reference は map ではなく snapshot に入っています。
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'roomId': roomId,
      'createdAt': createdAt,
      'posterName': posterName,
      'posterImageUrl': posterImageUrl,
      'posterId': posterId,
      'stamps': stamps,
      'replyCount': replyCount,
      'imageUrl': imageUrl,
      'imageLocalPath': imageLocalPath,
      'id': id
      // 'reference': reference, reference は field に含めなくてよい
      // field に含めなくても DocumentSnapshot に reference が存在するため
    };
  }
}
