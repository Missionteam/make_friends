import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as io;
import 'package:intl/intl.dart';

import '../functions/firestore_functions.dart';
import '../provider/users_provider.dart';

Future<void> uploadImages(
  BuildContext context,
  String fileName,
) async {
  final path = await select_icon(context);
  if (path == null) {
    return;
  }
  return uploadFile(path,
      '$fileName/${DateFormat('MMddHH:mm:ssSSS').format(Timestamp.now().toDate())}');
}

Future<File?> select_icon(BuildContext context,
    {String title = '画像を選択'}) async {
  const List<String> SELECT_ICON_OPTIONS = ["写真から選択", "写真を撮影"];
  const int GALLERY = 0;
  const int CAMERA = 1;

  var SelectType = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          alignment: Alignment.center,
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          children: SELECT_ICON_OPTIONS.asMap().entries.map((e) {
            return SimpleDialogOption(
              child: ListTile(
                title: Text(
                  e.value,
                  textAlign: TextAlign.center,
                ),
              ),
              onPressed: () => Navigator.of(context).pop(e.key),
            );
          }).toList(),
        );
      });

  final picker = ImagePicker();
  ImageSource imgScr;

  if (SelectType == null) {
    return null;
  }
  //カメラで撮影
  else if (SelectType == CAMERA) {
    imgScr = ImageSource.camera;
  }
  //ギャラリーから選択
  else if (SelectType == GALLERY) {
    imgScr = ImageSource.gallery;
  }

  final pickedFile = await picker.pickImage(source: imgScr);

  if (pickedFile == null) {
    return null;
  } else {
    final image = File(pickedFile.path);
    return image;
  }
}

Future<void> uploadFile(File localFile, String uploadFileName) async {
  final FirebaseStorage storage = FirebaseStorage.instance;
  Reference ref = storage.ref().child("images"); //保存するフォルダ

  io.File file = localFile;
  UploadTask task = ref.child(uploadFileName).putFile(file);

  try {
    var snapshot = await task;
  } catch (FirebaseException) {
    //エラー処理
  }
}

final cloudStorageRefProvider = Provider<Reference>((ref) {
  return FirebaseStorage.instance.ref().child('images');
});

Future<Image?> getImage(String imgPathLocal, String imgPathRemote) async {
  bool existLocal = await io.File(imgPathLocal).exists();

  if (existLocal) {
    return Image.file(File(imgPathLocal));
  } else {
    if ((imgPathRemote != "") && (imgPathRemote != null)) {
      try {
        //ローカルに存在しない場合はリモートのデータをダウンロード
        final imgUrl = await FirebaseStorage.instance
            .ref()
            .child("images")
            .child(imgPathRemote)
            .getDownloadURL();
        return Image.network(imgUrl);
      } catch (FirebaseException) {
        return null;
      }
    } else {
      return null;
    }
  }
}

final imageUrlProvider = FutureProvider.family((ref, String remotePath) async {
  if (remotePath == '') {
    return null;
  }
  final url = await ref
      .watch(cloudStorageRefProvider)
      .child(remotePath)
      .getDownloadURL();
  return (url != '') ? url : null;
});

final imageOfPostProvider = FutureProvider.family((ref, String remotePath,
    {double width = 300, double height = 300}) async {
  if (remotePath == '') {
    return const SizedBox();
  }
  final url = await ref
      .watch(cloudStorageRefProvider)
      .child(remotePath)
      .getDownloadURL();
  return (url != '')
      ? SizedBox(
          height: height,
          child: CachedNetworkImage(
            imageUrl: url,
            placeholder: ((context, url) => const SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(
                  strokeWidth: 0,
                ))),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ))
      : const SizedBox();
});

// class ImageOfPost extends ConsumerStatefulWidget {
//   ImageOfPost({super.key, this.imgPathLocal = '', this.imgPathRemote = ''});
//   String imgPathLocal;
//   String imgPathRemote;

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _ImageOfPostState();
// }

// class _ImageOfPostState extends ConsumerState<ImageOfPost> {

//   @override
//   Widget build(BuildContext context) {
//     bool existLocal = await io.File(imgPathLocal).exists();

//     return ();
//   }
// }

Future<File?> select_myIcon(WidgetRef ref, BuildContext context,
    {String title = '画像を選択'}) async {
  const List<String> SELECT_ICON_OPTIONS = ["写真から選択", "初期画像に戻す"];
  const int GALLERY = 0;
  const int CAMERA = 1;
  final isGirl = ref.watch(isGirlProvider);
  var SelectType = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          alignment: Alignment.center,
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          children: SELECT_ICON_OPTIONS.asMap().entries.map((e) {
            return SimpleDialogOption(
              child: ListTile(
                title: Text(
                  e.value,
                  textAlign: TextAlign.center,
                ),
              ),
              onPressed: () => Navigator.of(context).pop(e.key),
            );
          }).toList(),
        );
      });

  final picker = ImagePicker();
  ImageSource imgScr;

  if (SelectType == null) {
    return null;
  } else if (SelectType == CAMERA) {
    final initImage = (isGirl) ? 'Girl' : 'Boy';
    updateUserData(ref, field: 'photoUrl', value: initImage);
    return null;
  }
  //ギャラリーから選択
  else if (SelectType == GALLERY) {
    imgScr = ImageSource.gallery;
  }

  final pickedFile = await picker.pickImage(source: imgScr);

  if (pickedFile == null) {
    return null;
  } else {
    final image = File(pickedFile.path);
    return image;
  }
}
