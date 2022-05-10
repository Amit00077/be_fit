// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workout_timer_app/model/counter.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // final CountDownTimerState TimerState = Get.put(CountDownTimerState());
  final Counter counter = Get.put(Counter());

  // @override
  // void initState() {
  //   super.initState();
  //   TimerState.buildTimer();
  // }
  @override
  void initState() {
    super.initState();
    counter.buildTimer();
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: Center(
    //     child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           const Text('Count Down Timer using GetX State management'),
    //           GetBuilder<CountDownTimerState>(
    //               builder: (_) => TimerState.buildTimer()),
    //           Row(
    //             children: [
    //               ElevatedButton(
    //                   onPressed: () {
    //                     TimerState.startTimer();
    //                   },
    //                   child: const Text("start")),
    //               ElevatedButton(
    //                   onPressed: () {
    //                     TimerState.Pause();
    //                   },
    //                   child: const Text("pause")),
    //               ElevatedButton(
    //                   onPressed: () {
    //                     TimerState.reset();
    //                   },
    //                   child: const Text("reset")),
    //             ],
    //           )
    //         ]),
    //   ),
    // );
    return Scaffold(
        body: Center(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Count Down Timer using GetX State management'),
        GetBuilder<Counter>(builder: (_) => counter.buildTimer()),
        Row(
          children: [
            ElevatedButton(
                onPressed: () {
                  counter.startcountdown();
                },
                child: const Text("start")),
            ElevatedButton(
                onPressed: () {
                  counter.Pause();
                },
                child: const Text("pause")),
            ElevatedButton(
                onPressed: () {
                  counter.reset();
                },
                child: const Text("reset")),
          ],
        )
      ],
    )));
  }
}
