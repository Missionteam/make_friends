import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/post.dart';
import '../models/user.dart';
import '../provider/posts_provider.dart';

Future<void> sendPost(
  WidgetRef ref,
  String imagePath,
  DocumentSnapshot<AppUser> userDoc,
) async {
  final posterId = userDoc.get('id');
  final posterImageUrl = userDoc.get('photoUrl');
  final posterName = userDoc.get('displayName') ?? 'かな';
  final newDocumentReference = ref.watch(postsReferenceProvider).doc();

  final newPost = Post(
    text: imagePath,
    createdAt: Timestamp.now(), // 投稿日時は現在とします
    posterName: posterName,
    posterImageUrl: posterImageUrl,
    posterId: posterId,
    stamps: '',
    reference: newDocumentReference,
  );
  newDocumentReference.set(newPost);
}
