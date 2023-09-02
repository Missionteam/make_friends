import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../provider/image_provider.dart';

class UserIcon extends ConsumerWidget {
  UserIcon({
    Key? key,
    required this.uid,
    this.radius = 60,
    this.isSelected = false,
  }) : super(key: key);
  final String uid;
  final double radius;
  bool isSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageWidget = ref.watch(iconProvider(uid)).value ??
        SizedBox(
          width: radius,
        );
    return Center(
      child: Container(
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 44, 214, 49), shape: BoxShape.circle),
        child: Padding(
          padding: EdgeInsets.all(isSelected ? 2.0 : 0),
          child: SizedBox(
            width: radius,
            height: radius,
            child: CircleAvatar(
              radius: radius,
              child: ClipOval(
                child:
                    SizedBox(width: radius, height: radius, child: imageWidget),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
