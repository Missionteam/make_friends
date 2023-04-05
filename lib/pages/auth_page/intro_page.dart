// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';

class IntroViewSample extends StatelessWidget {
  // PageViewModel型のリストを作成
  static final pages = [
    PageViewModel(
      pageColor: const Color(0xFFFF7A00),
      iconImageAssetPath: 'images/whatNowStamp/WorkBoyIcon.png',
      body: Text(
        '私たちは大学生の2人組で、遠距離の方のためのサービスの開発を目指しています。\n',
        style: TextStyle(
          fontSize: 18,
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          'この度は、私たちのアプリを試して頂いて、本当にありがとうございます！',
          style: TextStyle(fontSize: 26),
        ),
      ),
      mainImage: Image.asset(
        'images/whatNowStamp/WorkBoyIcon.png',
        height: 400.0,
        width: 400.0,
        alignment: Alignment.center,
      ),
      titleTextStyle: TextStyle(color: Colors.white),
      bodyTextStyle: TextStyle(color: Colors.white),
    ),
    PageViewModel(
      pageColor: Color.fromARGB(255, 232, 105, 77),
      iconImageAssetPath: 'images/whatNowStamp/WorkGirlIcon.png',
      body: SingleChildScrollView(
          child: Text(
        '私たちはどうすれば、「大切な人を大切にし続けられるか」をずっと話し合って来ました。でも、結局、実際に皆さんに使って頂かないと分からない。という結論に至りました。そこで、私たちのアイディアを皆さんに見て頂きたいです。',
        style: TextStyle(fontSize: 16),
      )),
      title: Text('今回の試験利用の目的'),
      mainImage: Image.asset(
        'images/whatNowStamp/WorkGirlIcon.png',
        height: 400.0,
        width: 400.0,
        alignment: Alignment.center,
      ),
      titleTextStyle: TextStyle(color: Colors.white),
      bodyTextStyle: TextStyle(color: Colors.white),
    ),
    PageViewModel(
      pageColor: Color.fromARGB(255, 228, 102, 12),
      iconImageAssetPath: 'images/whatNowStamp/WorkBoy1.png',
      body: SingleChildScrollView(
        child: Text(
          'このアプリは、「LINEでは話せない色んなこと」を「もっと恋人に伝える」ためのアプリです。\nまた、もう一つの目標として、「返信が返ってこない」ことの寂しさを感じさせないことを目指しています。',
          style: TextStyle(fontSize: 16),
        ),
      ),
      title: Align(alignment: Alignment.topLeft, child: Text('このアプリの\n 紹介')),
      mainImage: Image.asset(
        'images/whatNowStamp/WorkBoy1.png',
        height: 400.0,
        width: 400.0,
        alignment: Alignment.center,
      ),
      titleTextStyle: TextStyle(color: Colors.white),
      bodyTextStyle: TextStyle(color: Colors.white),
    ),
    PageViewModel(
      pageColor: Color.fromARGB(255, 246, 100, 100),
      iconImageAssetPath: 'images/whatNowStamp/WorkGirl1.png',
      body: SingleChildScrollView(
        child: Text(
          'ここで皆さまにお詫びなのですが、こちらのアプリはまだまだ開発途中となっております。最低限お使い頂けるようになっていますが、様々なところで機能の不足を感じるかと思います。\nなので、皆さまには、アプリ自体の性能というよりも、私たちの目指す機能に魅力を感じるか、というところを試して頂きたいです。',
          style: TextStyle(fontSize: 16),
        ),
      ),
      title: Text('お詫びとお願い'),
      mainImage: Image.asset(
        'images/whatNowStamp/WorkGirl1.png',
        height: 400.0,
        width: 400.0,
        alignment: Alignment.center,
      ),
      titleTextStyle: TextStyle(color: Colors.white),
      bodyTextStyle: TextStyle(color: Colors.white),
    ),
    PageViewModel(
      pageColor: Color.fromARGB(255, 241, 119, 119),
      iconImageAssetPath: 'images/whatNowStamp/Tworoom.png',
      body: SingleChildScrollView(
        child: Text(
          'もし、このアプリを使ってみて、「この機能好きだった」、「ぜんぜん使えなかった」などあればぜひ教えてください。\n 皆さんと、お話できるのを楽しみにしております。',
          style: TextStyle(fontSize: 16),
        ),
      ),
      title: Text('最後に'),
      mainImage: Image.asset(
        'images/whatNowStamp/Tworoom.png',
        height: 400.0,
        width: 400.0,
        alignment: Alignment.center,
      ),
      titleTextStyle: TextStyle(color: Colors.white),
      bodyTextStyle: TextStyle(color: Colors.white),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        child: IntroViewsFlutter(
      pages,
      showNextButton: true,
      onTapDoneButton: () {
        Navigator.of(context).pop();
      },
    )); // PageViewModelのリストを渡す
  }
}
