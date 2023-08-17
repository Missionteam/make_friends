import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:make_friends_app/provider/users_provider.dart';

import '../models/cloud_storage_model.dart';

final iconProvider = FutureProvider.family((ref, String uid) {
  final userDoc = ref.watch(uidUserDocProvider(uid)).value;

  final String iconName = userDoc?.get('photoUrl') ?? 'Girl';
  final imageUrl = (iconName != 'Boy' && iconName != 'Girl')
      ? ref.watch(imageUrlProvider(iconName)).value
      : null;
  final imageWidget = (imageUrl != null)
      ? CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
        )
      : (iconName == 'Boy' || iconName == 'Girl')
          ? Image(image: AssetImage('images/${iconName}Icon.png'))
          : SizedBox();
  return imageWidget;
});
