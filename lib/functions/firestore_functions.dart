import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/users_provider.dart';

void updateUserData(WidgetRef ref, {required String field, required value}) {
  final docRef = ref.watch(currentAppUserDocRefProvider);
  docRef.update({field: value});
}
