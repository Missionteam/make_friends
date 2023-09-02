import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:make_friends_app/models/express.dart';
import 'package:make_friends_app/provider/express/express_provider.dart';

import '../models/expressItem.dart';
import '../provider/auth_provider.dart';
import '../provider/users_provider.dart';

Future<void> sendExpress(WidgetRef ref, ExpressItem expressItem,
    [List<String>? openUsers]) async {
  final newDocumentReference = ref.watch(expressReferenceProvider).doc();
  final uid = ref.watch(uidProvider) ?? "anonymous";
  final userDoc = await ref.watch(currentAppUserDocProvider.future);
  final user = userDoc.data();
  final defaultSetting = userDoc.data()?.openSettings["default"];

  Express newExpress = Express(
    title: expressItem.title,
    openUsers: openUsers ?? defaultSetting ?? [],
    express: expressItem.express,
    imageUrl: expressItem.imageUrl,
    uid: uid,
    reference: newDocumentReference,
  );
  await newDocumentReference.set(newExpress);
  print(newExpress);
}
