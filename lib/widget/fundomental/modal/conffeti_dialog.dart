import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:make_friends_app/functions/send_plan.dart';

import '../../../functions/screen_size.dart';
import '../../../provider/cloud_messeging_provider.dart';
import '../../../utils/text.dart';
import '../textform/textform.dart';
import 'my_modal.dart';

class ConffetiDialog extends ConsumerStatefulWidget {
  const ConffetiDialog({super.key, required this.uid});
  final String uid;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ConffetiDialogState();
}

class _ConffetiDialogState extends ConsumerState<ConffetiDialog> {
  late ConfettiController _controller;
  late ConfettiController _controllerCenter;
  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  String _time = '';
  String _shop = '';
  String _meetingPlace = '';
  void _submission() {
    if (this._formKey.currentState!.validate()) {
      this._formKey.currentState!.save();
    }
    if (this._formKey1.currentState!.validate()) {
      this._formKey1.currentState!.save();
    }
    if (this._formKey2.currentState!.validate()) {
      this._formKey2.currentState!.save();
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = ConfettiController(duration: const Duration(seconds: 2));
    _controllerCenter =
        ConfettiController(duration: const Duration(milliseconds: 100));
    _controller.play();
    _controllerCenter.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    _controllerCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          BaseDialog(
              height: 500,
              width: sWidth(context) * 0.84,
              onButtonPressd: () => {},
              children: [
                NotoText(
                  text: 'ご飯の予定が決定しました🎊\n\n集合時間などを設定して、\nストレスフリーにご飯！！',
                  topPadding: 20,
                  fontSize: 12,
                ),
                TextForm(
                    formKey: _formKey,
                    text: '時間：',
                    hintText: '例：今日20時~',
                    initialValue: '',
                    fontSize: 20,
                    color: Color.fromARGB(255, 28, 28, 28),
                    onSaved: (String? value) {
                      this._time = value ?? '';
                    }),
                TextForm(
                    formKey: _formKey1,
                    text: 'お店：',
                    hintText: '例：中島屋',
                    initialValue: '',
                    fontSize: 20,
                    color: Color.fromARGB(255, 28, 28, 28),
                    onSaved: (String? value) {
                      this._shop = value ?? '';
                    }),
                TextForm(
                    formKey: _formKey2,
                    text: '集合：',
                    hintText: '例：出町のセブン前',
                    initialValue: '',
                    fontSize: 20,
                    color: Color.fromARGB(255, 28, 28, 28),
                    onSaved: (String? value) {
                      this._meetingPlace = value ?? '';
                    }),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(onPressed: (() {}), child: Text("Cancel")),
                    SizedBox(width: 40),
                    ElevatedButton(
                        onPressed: (() {
                          _submission();
                          sendPlan(ref, widget.uid,
                              meetingPlace: _meetingPlace,
                              place: _shop,
                              time: _time);
                          FirebaseCloudMessagingService().sendPushNotification(
                            token: "",
                            title: '通話の予定が決定しました🎊',
                            body: "_messege",
                            type: 'chat',
                          );
                          Navigator.of(context).pop(true);
                        }),
                        child: Text("保存")),
                  ],
                )
              ]),
          ConfettiSideWidget(
              controller: _controller,
              direction: pi,
              alignment: Alignment.topRight),
          ConfettiSideWidget(
              controller: _controller,
              direction: 0,
              alignment: Alignment.topLeft),
          ConfettiCenterWidget(
              controllerCenter: _controllerCenter, direction: pi / 3),
          ConfettiCenterWidget(
              controllerCenter: _controllerCenter, direction: 2 * pi / 3),
          ConfettiCenterWidget(
              controllerCenter: _controllerCenter, direction: pi / 2),
        ],
      ),
    );
  }
}

class ConfettiSideWidget extends StatelessWidget {
  const ConfettiSideWidget(
      {Key? key,
      required ConfettiController controller,
      required this.direction,
      required this.alignment})
      : _controller = controller,
        super(key: key);

  final ConfettiController _controller;
  final double direction;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: ConfettiWidget(
        confettiController: _controller,
        blastDirectionality: BlastDirectionality.explosive,
        blastDirection: direction,
        maxBlastForce: 13,
        minBlastForce: 0.1,
        particleDrag: 0.05, // apply drag to the confetti
        emissionFrequency: 0.05, // how often it should emit
        numberOfParticles: 8, // number of particles to emit
        gravity: 0.05, // gravity - or fall speed
        shouldLoop: false,
        colors: const [
          Color.fromARGB(255, 145, 254, 149),
          Color.fromARGB(255, 83, 172, 244),
          Color.fromARGB(255, 255, 172, 200)
        ], // manually specify the colors to be used
      ),
    );
  }
}

class ConfettiCenterWidget extends StatelessWidget {
  const ConfettiCenterWidget({
    Key? key,
    required ConfettiController controllerCenter,
    required this.direction,
  })  : _controllerCenter = controllerCenter,
        super(key: key);

  final ConfettiController _controllerCenter;
  final double direction;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConfettiWidget(
        confettiController: _controllerCenter,
        blastDirectionality: BlastDirectionality.explosive,
        blastDirection: direction,
        maxBlastForce: 50,
        minBlastForce: 10,
        particleDrag: 0.05, // apply drag to the confetti
        emissionFrequency: 0.6, // how often it should emit
        numberOfParticles: 6, // number of particles to emit
        gravity: 0.05, // gravity - or fall speed
        shouldLoop: false,
        colors: const [
          Color.fromARGB(255, 145, 254, 149),
          Color.fromARGB(255, 83, 172, 244),
          Color.fromARGB(255, 255, 172, 200)
        ], // manually specify the colors to be used
      ),
    );
  }
}
