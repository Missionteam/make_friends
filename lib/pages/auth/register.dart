import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../provider/users_provider.dart';

enum RadioValue {
  FIRST,
  SECOND,
}

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  String name = '';
  RadioValue _gValue = RadioValue.FIRST;
  _onRadioSelected(value) {
    setState(() {
      _gValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userDoc = ref.watch(currentAppUserDocRefProvider);

    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(right: 10, bottom: 20),
                      child: CircleAvatar(
                          radius: 60,
                          foregroundImage: AssetImage('images/GirlIcon.png')),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 10, bottom: 20),
                      child: CircleAvatar(
                          radius: 60,
                          foregroundImage: AssetImage('images/BoyIcon.png')),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'ふたりべやを始めましょう！',
                  style: GoogleFonts.nunito(
                      fontSize: 24, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'お名前'),
                  onChanged: (String value) {
                    setState(() {
                      name = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
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
                    const Text('女性'),
                    const SizedBox(
                      width: 50,
                    ),
                    Radio(
                        // title: Text('男性'),
                        value: RadioValue.SECOND,
                        groupValue: _gValue,
                        onChanged: (value) {
                          _onRadioSelected(value);
                        }),
                    const Text('男性'),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                // 3行目 ユーザ登録ボタン
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    child: const Text('登録完了'),
                    onPressed: () async {
                      try {
                        bool isGirl =
                            (_gValue == RadioValue.FIRST) ? true : false;
                        String userimage = (isGirl == true) ? 'Girl' : 'Boy';
                        userDoc.update({'displayName': name});
                        userDoc.update({'isGirl': isGirl});
                        userDoc.update({'photoUrl': userimage});

                        // showDialog(
                        //     context: context,
                        //     builder: (_) {
                        //       return AlertDialog(
                        //         title: Text('ご登録ありがとうございます！'),
                        //         content: Text('恋人との連携は、ホーム画面の設定から行えます。'),
                        //         actions: [
                        //           TextButton(
                        //             child: Text('OK'),
                        //             onPressed: (() {
                        //               Navigator.of(context).pop();
                        //             }),
                        //           )
                        //         ],
                        //       );
                        //     });
                        Navigator.of(context).pop();
                        // Navigator.of(context)
                        //     .push(MaterialPageRoute(builder: (context) {
                        //   return MyApp();
                        // }));
                      } catch (e) {
                        print(e);
                      }
                    },
                  ),
                ),
                // 4行目 ログインボタン

                // 5行目 パスワードリセット登録ボタン
              ],
            ),
          ),
        ),
      ),
    );
  }
}
