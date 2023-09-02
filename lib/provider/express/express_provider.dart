import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/express.dart';
import '../../models/expressItem.dart';
import '../firebase_provider.dart';

///ExpressReferenceProviderが提供する
///ReferenceにあるExpressを取得するプロバイダー
final expressByCategoryProvider =
    StreamProvider<Map<String, List<Express>>>((ref) {
  final expressReference = ref.watch(expressReferenceProvider);
  return expressReference
      // .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snapshot) {
    final allExpresses = snapshot.docs.map((doc) => doc.data()).toList();
    Map<String, List<Express>> categorizedExpresses = {};

    // expressListからカテゴリを動的に初期化
    for (var item in expressList) {
      categorizedExpresses[item.express] = [];
    }

    for (var express in allExpresses) {
      print(express);
      if (categorizedExpresses.containsKey(express.express)) {
        categorizedExpresses[express.express]!.add(express);
      }
    }

    return categorizedExpresses;
  });
});

///現在のtalkroom直下のExpressのReferenceを取得するプロバイダー
final expressReferenceProvider = Provider<CollectionReference<Express>>((ref) {
  final firestore = ref.read(firestoreProvider);
  return firestore.collection('express').withConverter<Express>(
        fromFirestore: ((snapshot, _) => Express.fromFirestore(snapshot)),
        toFirestore: ((value, _) => value.toJson()),
      );
});
