import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/users_provider.dart';

void updateUserData(WidgetRef ref, {String field = '', String value = ''}) {
  final docRef = ref.watch(currentAppUserDocRefProvider);
  docRef.update({field: value});
}

void updatePartnerData(WidgetRef ref, {String field = '', String value = ''}) {
  final docRef = ref.watch(partnerUserDocRefProvider);
  docRef.update({field: value});
}
