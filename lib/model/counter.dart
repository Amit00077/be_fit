// ignore_for_file: non_constant_identifier_names, unnecessary_string_interpolations

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Counter extends GetxController {
  late Timer _time;
  static const countdownDuration = Duration(seconds: 12);
  bool isrunning = false;
  Duration duration = const Duration(seconds: 12);
  void startcountdown() {
    isrunning = true;
    update();
    _time =
        Timer.periodic(const Duration(milliseconds: 1350), (_) => addcount());
  }

  void addcount() {
    final seconds = duration.inSeconds - 1;
    update();
    if (seconds < 0) {
      _time.cancel();
      update();
    } else if (seconds >= 0) {
      duration = Duration(seconds: seconds);
      update();
    }
  }

  Widget buildTimer() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text("$seconds", style: const TextStyle(fontSize: 70)),
    ]);
  }

  void reset() {
    duration = countdownDuration;
    _time.cancel();
    update();
  }

  void Pause() {
    _time.cancel();
    update();
  }
}
