import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:make_friends_app/pages/auth_page/register.dart';

import '../../models/auth_model.dart';

enum Status {
  login,
  signUp,
}

Status type = Status.login;

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return const RegisterPage();
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authenticationProvider);
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            child: const Text('GoogleSignIn'),
            onPressed: () async {
              await auth.signInWithGoogle(context);
              // ignore: avoid_print
              print(FirebaseAuth.instance.currentUser?.displayName);
              // ログインに成功したら ChatPage に遷移します。
              // 前のページに戻らせないようにするにはpushAndRemoveUntilを使います。

              // if (mounted) {
              //   ref.watch(talkroomReferenceProvider).when(
              //       data: ((data) {
              //         print('good');
              //         return;
              //       }),
              //       error: ((e, trace) => print('but')),
              //       loading: () => print('norm'));
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) {
                  return const RegisterPage();
                }),
                (route) => false,
              );
            }),
      ),
    );
  }
}
