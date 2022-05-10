// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:workout_timer_app/view/pages/abs.dart';

import '../../constants/color.dart';
import '../../model/counter.dart';

class PushUp extends StatefulWidget {
  const PushUp({Key? key}) : super(key: key);

  @override
  State<PushUp> createState() => _PushUpState();
}

class _PushUpState extends State<PushUp> {
  final Counter counter = Get.put(Counter());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: backgroundcolor,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: InkWell(
                child: const Icon(Icons.arrow_back, color: Colors.black),
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const HomePage()),
                  // );
                  Navigator.pop(context);

                  if (counter.isrunning == true) {
                    counter.reset();
                  }
                }),
            title: Text(
              "Push Up",
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
          ),
          body: Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Neumorphic(
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.flat,
                      color: buttoncolor,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(8)),
                    ),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 4.5,
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: Image.asset('assets/images/push-up-guy.gif'),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 120,
                  width: 120,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CircularProgressIndicator(
                        strokeWidth: 10,
                        value: 1 / 1,
                        valueColor: AlwaysStoppedAnimation(Colors.greenAccent),
                      ),
                      Center(
                        child: GetBuilder<Counter>(
                            builder: (_) => counter.buildTimer()),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    NeumorphicButton(
                      style: NeumorphicStyle(
                        shape: NeumorphicShape.flat,
                        color: buttoncolor,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(8)),
                      ),
                      onPressed: () {
                        counter.startcountdown();
                      },
                      child: const Text(
                        "start",
                        style: TextStyle(color: textcolor, fontSize: 24),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 10,
                    ),
                    NeumorphicButton(
                      style: NeumorphicStyle(
                        shape: NeumorphicShape.flat,
                        color: buttoncolor,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(8)),
                      ),
                      onPressed: () {
                        if (counter.isrunning) {
                          counter.Pause();
                        }
                      },
                      child: const Text(
                        "pause",
                        style: TextStyle(color: textcolor, fontSize: 24),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 10,
                    ),
                    NeumorphicButton(
                      style: NeumorphicStyle(
                        shape: NeumorphicShape.flat,
                        color: buttoncolor,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(8)),
                      ),
                      onPressed: () {
                        if (counter.isrunning) {
                          counter.reset();
                        }
                      },
                      child: const Text(
                        "reset",
                        style: TextStyle(color: textcolor, fontSize: 24),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Neumorphic(
                  style: NeumorphicStyle(
                    shape: NeumorphicShape.flat,
                    color: buttoncolor,
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
                  ),
                  child: Column(children: [
                    const Flexible(
                      child: Padding(
                        padding: EdgeInsets.only(left: 12, right: 12, top: 8),
                        child: SingleChildScrollView(
                          child: Expanded(
                            child: Text(
                              "A push-up (sometimes called a press-up in British English) is a common calisthenics exercise beginning from the prone position. By raising and lowering the body using the arms, push-ups exercise the pectoral muscles, triceps, and anterior deltoids, with ancillary benefits to the rest of the deltoids, serratus anterior coracobrachialis and the midsection as a whole. Push-ups are a basic exercise used in civilian athletic training or physical education and commonly in military physical training. They are also a common form of punishment used in the military, school sport, and some martial arts disciplines.",
                              style: TextStyle(
                                color: textcolor,
                                fontSize: 23,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: 5,
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: NeumorphicButton(
                          style: NeumorphicStyle(
                            shape: NeumorphicShape.flat,
                            color: navbarcolor,
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(8)),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Abs()),
                            );
                            if (counter.isrunning == true) {
                              counter.reset();
                            }
                          },
                          child: const Text(
                            "Next",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24),
                          )),
                    ),
                  ]),
                ),
              ),
            ],
          ))),
    );
  }
}
