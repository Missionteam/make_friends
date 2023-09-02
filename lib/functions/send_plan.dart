import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:make_friends_app/models/plan.dart';
import 'package:make_friends_app/provider/express/plans_provider.dart';

import '../provider/auth_provider.dart';

Future<void> sendPlan(WidgetRef ref, String uid,
    {String? time, String? place, String? meetingPlace}) async {
  final newDocumentReference = ref.watch(plansReferenceProvider).doc();
  final myuid = ref.watch(uidProvider);

  final newPost = Plan(
    users: [uid, myuid!],
    place: place,
    meetingPlace: meetingPlace,
    createdAt: Timestamp.now(), // 投稿日時は現在とします
    reference: newDocumentReference,
  );
  newDocumentReference.set(newPost);
}
