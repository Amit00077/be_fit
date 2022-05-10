// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:workout_timer_app/view/pages/pushup_page.dart';

import '../../constants/color.dart';
import '../../model/counter.dart';

class PullUP extends StatefulWidget {
  const PullUP({Key? key}) : super(key: key);

  @override
  State<PullUP> createState() => _PullUPState();
}

class _PullUPState extends State<PullUP> {
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
            title: Text("Pull Up", style: TextStyle(color: Colors.black)),
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
                      child: Image.asset('assets/images/spiderman-pull-up.gif'),
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
                              "A pull-up is an upper-body strength exercise. The pull-up is a closed-chain movement where the body is suspended by the hands and pulls up. As this happens, the elbows flex and the shoulders adduct and extend to bring the elbows to the torso.",
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
                                  builder: (context) => const PushUp()),
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
