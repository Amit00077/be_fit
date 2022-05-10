// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use, sized_box_for_whitespace, prefer_final_fields
import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:workout_timer_app/constants/color.dart';
import 'package:workout_timer_app/services/shared_pref.dart';
import 'package:workout_timer_app/view/history.dart';

class FoodSearch extends StatefulWidget {
  const FoodSearch({Key? key}) : super(key: key);

  @override
  State<FoodSearch> createState() => _FoodSearchState();
}

class _FoodSearchState extends State<FoodSearch> {
  final TextEditingController _food = TextEditingController();
  bool isShow = false;
  String pro = '0';
  String energy = '0';
  String fat = '0';
  String carb = '0';
  bool status = false;
  Connectivity _connectivity = Connectivity();
  late StreamSubscription _streamSubscription;
  final snackBar = SnackBar(
    content: Text('Check Your Connection!!'),
  );

  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
    checkRealtimeConnection();
  }

  void checkConnectivity() async {
    var connectionResult = await _connectivity.checkConnectivity();

    if (connectionResult == ConnectivityResult.mobile) {
      status = true;
    } else if (connectionResult == ConnectivityResult.wifi) {
      status = true;
    } else {
      status = false;
    }
    setState(() {});
  }

  void checkRealtimeConnection() {
    _streamSubscription = _connectivity.onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.mobile) {
        status = true;
      } else if (event == ConnectivityResult.wifi) {
        status = true;
      } else {
        status = false;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _food.dispose();
    _streamSubscription.cancel();
  }

  void getdata(String food) async {
    var responce = await http.get(Uri.parse(
        'https://api.nal.usda.gov/fdc/v1/foods/search?query=$food&pageSize=1&api_key=PIV1igFOi45PQTa6tqegayHuMgt9k2MjeuZrcDnh'));
    if (responce.statusCode == 200) {
      String data = responce.body;
      var decode = jsonDecode(data);
      try {
        setState(() {
          pro = decode['foods'][0]['foodNutrients'][0]['value'].toString();
          energy = decode['foods'][0]['foodNutrients'][3]['value'].toString();
          fat = decode['foods'][0]['foodNutrients'][1]['value'].toString();
          carb = decode['foods'][0]['foodNutrients'][2]['value'].toString();
        });
      } catch (e) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(
            "Error,Can't find it.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
          ),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.blue,
        ));
      }

      // print(protein);
      // print(energy);
      // print(fat);
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(
          "Error,Can't find it.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
        ),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.blue,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Material(
        color: backgroundcolor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Text(
                    "Enter Food Name to get it's nutritional value",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: textcolor,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Neumorphic(
                style: NeumorphicStyle(
                    shape: NeumorphicShape.concave,
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                    depth: 8,
                    lightSource: LightSource.topLeft,
                    color: backgroundcolor),
                child: TextFormField(
                  style: TextStyle(color: textcolor, fontSize: 20),
                  controller: _food,
                  decoration: const InputDecoration(
                    // labelText: 'Food',
                    // labelStyle: TextStyle(color: textcolor),
                    hintText: 'Enter Food',
                    hintStyle: TextStyle(fontSize: 20),
                    contentPadding: EdgeInsets.all(10),
                    // border: OutlineInputBorder(),
                  ),
                  onChanged: (String _) {
                    setState(() {
                      isShow = true;
                    });
                  },
                ),
              ),
            ),
            // SizedBox(
            //   height: 10,
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: NeumorphicButton(
                margin: EdgeInsets.only(top: 12),
                onPressed: () {
                  if (isShow == true && status == true) {
                    getdata(_food.text);
                  } else if (status == false) {
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  addtask(_food.text);
                  FocusScope.of(context).unfocus();
                },
                style: NeumorphicStyle(
                  shape: NeumorphicShape.flat,
                  color: buttoncolor,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
                ),
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  child: Text(
                    "show",
                    style: TextStyle(fontSize: 20, color: textcolor),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: NeumorphicButton(
                margin: EdgeInsets.only(top: 12),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const History()),
                  );
                  FocusScope.of(context).unfocus();
                },
                style: NeumorphicStyle(
                  shape: NeumorphicShape.flat,
                  color: buttoncolor,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
                ),
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  child: Text(
                    "History",
                    style: TextStyle(fontSize: 20, color: textcolor),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Neumorphic(
              style: NeumorphicStyle(
                  shape: NeumorphicShape.convex,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
                  depth: 8,
                  lightSource: LightSource.topLeft,
                  color: buttoncolor),
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Protein = $pro gram",
                          style: TextStyle(fontSize: 30, color: textcolor),
                        ),
                        Text("Carbohydrate = $carb gram",
                            style: TextStyle(fontSize: 30, color: textcolor)),
                        Text("Energy = $energy Kcal",
                            style: TextStyle(fontSize: 30, color: textcolor)),
                        Text("Fat = $fat gram",
                            style: TextStyle(fontSize: 30, color: textcolor)),
                        SizedBox(
                          height: 40,
                        ),
                        (double.parse(pro) < 20 &&
                                double.parse(fat) > 30 &&
                                double.parse(energy) > 200)
                            ? Neumorphic(
                                style: NeumorphicStyle(
                                    shape: NeumorphicShape.concave,
                                    boxShape: NeumorphicBoxShape.roundRect(
                                        BorderRadius.circular(12)),
                                    depth: 8,
                                    lightSource: LightSource.topLeft,
                                    color: buttoncolor),
                                child: Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: Text("It's unhealthy",
                                      style: TextStyle(fontSize: 30)),
                                ),
                              )
                            : Neumorphic(
                                style: NeumorphicStyle(
                                    shape: NeumorphicShape.concave,
                                    boxShape: NeumorphicBoxShape.roundRect(
                                        BorderRadius.circular(12)),
                                    depth: 8,
                                    lightSource: LightSource.topLeft,
                                    color: buttoncolor),
                                child: Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: Text(
                                      "Know your food to stay\n * HEALTHY *",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 30)),
                                ),
                              ),
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
