import 'package:cloud_firestore/cloud_firestore.dart';

class Plan {
  Plan({
    required this.users,
    required this.createdAt,
    this.place,
    this.time,
    this.meetingPlace,
    required this.reference,
    this.stamps,
    this.id = '',
    this.replyCount = 0,
    this.imageUrl = '',
    this.imageLocalPath = '',
  });
  final List<String> users;

  final Timestamp createdAt;
  final String? place;
  final DateTime? time;
  final String? meetingPlace;
  final String? stamps;
  final String imageUrl;
  final String imageLocalPath;
  final String id;

  final DocumentReference reference;
  final int replyCount;
  factory Plan.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final map = snapshot.data()!;
    List<dynamic> rawUsers = map['users'] ?? [""]; // これがあなたが取得したデータです。
    List<String> users = rawUsers.cast<String>();
    return Plan(
      users: users,
      createdAt: map['createdAt'],
      place: map['place'],
      time: map['time'],
      meetingPlace: map['meetingPlace'],
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
      'users': users,

      'createdAt': createdAt,
      'place': place,
      'time': time,
      'meetingPlace': meetingPlace,
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
