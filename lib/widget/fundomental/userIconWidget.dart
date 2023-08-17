import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../provider/image_provider.dart';

class UserIcon extends ConsumerWidget {
  const UserIcon({
    Key? key,
    required this.uid,
    this.radius = 10,
  }) : super(key: key);
  final String uid;
  final double radius;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageWidget = ref.watch(iconProvider(uid)).value ??
        SizedBox(
          width: radius,
        );
    return SizedBox(
      width: radius,
      height: radius,
      child: CircleAvatar(
        radius: radius,
        child: ClipOval(
          child: SizedBox(width: radius, height: radius, child: imageWidget),
        ),
      ),
    );
  }
}
