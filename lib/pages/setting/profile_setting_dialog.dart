import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../models/cloud_storage_model.dart';
import '../../../pages/auth/register.dart';
import '../../provider/auth_provider.dart';
import '../../provider/users_provider.dart';
import '../../widget/fundomental/userIconWidget.dart';
import 'setting_page.dart';

class MyProfileSettingPage extends ConsumerStatefulWidget {
  const MyProfileSettingPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MyProfileSettingPageState();
}

class _MyProfileSettingPageState extends ConsumerState<MyProfileSettingPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String imageLocalPath = '';
  String imageCloudPath = '';
  File? imageFile;

  RadioValue _gValue = RadioValue.FIRST;
  _onRadioSelected(value) {
    setState(() {
      _gValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentUserDoc = ref.watch(currentAppUserDocProvider).value;
    final partnerUseDoc = ref.watch(partnerUserDocProvider).value;
    final uid = ref.watch(uidProvider);
    final String partnerName =
        partnerUseDoc?.get('displayName') ?? '恋人が登録されていません。';
    final String currentUserImageName =
        currentUserDoc?.get('photoUrl') ?? 'Girl';
    final String currentUserName =
        currentUserDoc?.get('displayName') ?? 'お名前を登録してください。';
    final imageUrl = ref.watch(imageUrlProvider(imageCloudPath)).value;

    void _submission() {
      if (this._formKey.currentState!.validate()) {
        this._formKey.currentState!.save();
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 5,
            ),
            IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(
                  Icons.chevron_left_outlined,
                  color: Color.fromARGB(255, 0, 0, 0),
                )),
          ],
        ),
        backgroundColor: Color.fromARGB(0, 250, 250, 250),
        toolbarHeight: 100,
        centerTitle: true,
        title: Text(
          '個人設定',
          style: GoogleFonts.nunito(
            fontSize: 22,
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 90, 90, 90),
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            InkWell(
                onTap: () async {
                  final image =
                      await select_myIcon(ref, context, title: 'アイコン画像を選択');

                  if (image != null) {
                    final imageRemotePath =
                        '${DateFormat('MMddHH:mm:ssSSS').format(Timestamp.now().toDate())}';
                    await uploadFile(image, imageRemotePath);
                    setState(() {
                      this.imageFile = image;
                      imageCloudPath = imageRemotePath;
                    });
                    final url = ref.watch(imageUrlProvider(imageCloudPath));

                    showDialog(
                        context: context,
                        builder: (_) {
                          return IconChangeDialog(
                            imageFile: imageFile,
                            imageRocalPath: imageCloudPath,
                          );
                        });
                  }
                },
                child: UserIcon(
                  uid: uid!,
                  radius: 150,
                )),
            Form(
                key: _formKey,
                child: Container(
                    padding: const EdgeInsets.only(
                        top: 40.0, left: 60, right: 60, bottom: 20),
                    child: new TextFormField(
                      enabled: true,
                      maxLength: 20,
                      obscureText: false,
                      initialValue: currentUserName,
                      decoration: const InputDecoration(
                        hintText: 'お名前を教えてください',
                        labelText: '名前 ',
                      ),
                      onSaved: (String? value) {
                        this._name = value ?? '';
                      },
                    ))),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                    // title: Text('女性'),
                    value: RadioValue.FIRST,
                    groupValue: _gValue,
                    onChanged: (value) {
                      _onRadioSelected(value);
                    }),
                Text('女性'),
                SizedBox(
                  width: 50,
                ),
                Radio(
                    // title: Text('男性'),
                    value: RadioValue.SECOND,
                    groupValue: _gValue,
                    onChanged: (value) {
                      _onRadioSelected(value);
                    }),
                Text('男性'),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('恋人：${partnerName}'),
                  Container(
                    height: 37,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(255, 238, 238, 238),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.border_color_rounded,
                          size: 15,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          '連携',
                          style: GoogleFonts.nunito(fontSize: 15),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            TextButton(
                onPressed: () {
                  bool isGirl = (_gValue == RadioValue.FIRST) ? true : false;
                  String userimage = (isGirl == true) ? 'Girl' : 'Boy';
                  _submission();
                  ref.watch(currentAppUserDocRefProvider).update({
                    'displayName': this._name,
                    'photoUrl': userimage,
                    'isGirl': isGirl
                  });

                  Navigator.of(context).pop();
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  fixedSize: Size(150, 40),
                ),
                child: Text(
                  '保存',
                  style: GoogleFonts.nunito(
                      // color: Color.fromARGB(255, 243, 243, 243)),
                      color: Colors.white),
                )),
          ]),
        ),
      ),
    );
  }
}
