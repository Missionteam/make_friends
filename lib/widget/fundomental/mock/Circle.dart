import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyCircle extends ConsumerWidget {
  const MyCircle({super.key, this.color = Colors.blue, this.radius = 10});
  final Color color;
  final double radius;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius), color: color),
    );
  }
}
