import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/plan.dart';
import '../firebase_provider.dart';

///planReferenceProviderが提供する
///ReferenceにあるPostを取得するプロバイダー
final plansProvider = StreamProvider((ref) {
  final plansReference = ref.watch(plansReferenceProvider);
  return plansReference.orderBy('createdAt', descending: true).snapshots();
});

///現在のtalkroom直下のplanのReferenceを取得するプロバイダー
final plansReferenceProvider = Provider<CollectionReference<Plan>>((ref) {
  final firestore = ref.read(firestoreProvider);
  return firestore.collection('plans').withConverter<Plan>(
        fromFirestore: ((snapshot, _) => Plan.fromFirestore(snapshot)),
        toFirestore: ((value, _) => value.toJson()),
      );
});
