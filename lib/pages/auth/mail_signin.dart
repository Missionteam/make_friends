// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/auth_model.dart';
import '../../provider/cloud_messeging_provider.dart';
import 'register.dart';

class MailSignInPage extends ConsumerStatefulWidget {
  const MailSignInPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MailSignInPageState();
}

class _MailSignInPageState extends ConsumerState<MailSignInPage> {
  String email = '';
  String password = '';
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authenticationProvider);
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
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
                    decoration: const InputDecoration(labelText: 'メールアドレス'),
                    onChanged: (String value) {
                      setState(() {
                        email = value;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // 2行目 パスワード入力用テキストフィールド
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'パスワード'),
                    obscureText: true,
                    validator: (String? value) {
                      return (value!.length < 6) ? 'パスワードは6文字以上にしてください。' : null;
                    },
                    onChanged: (String value) {
                      setState(() {
                        password = value;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // 3行目 ユーザ登録ボタン
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          child: const Text('ユーザ登録'),
                          onPressed: () async {
                            try {
                              if (formKey.currentState!.validate()) {
                                await auth.signInWithMail(
                                    context, email, password);
                                FirebaseCloudMessagingService().fcmGetToken();
                                // Navigator.of(context).pop();
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (context) {
                                  return const RegisterPage();
                                }));
                              }
                            } catch (e) {
                              print(e);
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          child: const Text('ログイン'),
                          onPressed: () async {
                            try {
                              // メール/パスワードでログイン
                              final User? user = (await FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                          email: email, password: password))
                                  .user;
                              FirebaseCloudMessagingService().fcmGetToken();
                              if (user != null) {
                                print("ログインしました　${user.email} , ${user.uid}");
                              }
                              Navigator.of(context).pop();
                            } catch (e) {
                              print(e);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  // 4行目 ログインボタン

                  // 5行目 パスワードリセット登録ボタン
                  MaterialButton(
                      child: const Text('パスワードリセット'),
                      onPressed: () async {
                        try {
                          await FirebaseAuth.instance
                              .sendPasswordResetEmail(email: email);
                          print("パスワードリセット用のメールを送信しました");
                        } catch (e) {
                          print(e);
                        }
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
