// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class CountDownTimer extends GetxController {
  static const countdownDuration = Duration(minutes: 5);

  Duration duration = Duration(minutes: 5);
  bool isrunning = false;

  late Timer _timer;
  void startTimer() {
    isrunning = true;

    _timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
  }

  void addTime() {
    final seconds = duration.inSeconds - 1;
    if (seconds < 0) {
      _timer.cancel();
    } else {
      duration = Duration(seconds: seconds);
      update();
    }
  }

  Widget buildTimer() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        "$minutes:$seconds",
        style: TextStyle(fontSize: 40),
      )
    ]);
  }

  void reset() {
    duration = countdownDuration;
    _timer.cancel();
    update();
  }

  void Pause() {
    _timer.cancel();
    update();
  }
}
