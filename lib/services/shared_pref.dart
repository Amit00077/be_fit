// ignore_for_file: non_constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

int Length = 0;
List<String> foods = [];
addtask(String food) async {
  int index = 0;
  foods.insert(index, food);
  index++;
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setStringList('FOOD', foods);
  // print(food);
}

gettask() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  List<String>? getfood = pref.getStringList('FOOD');
  return getfood;
}

delete() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.clear();
}

getlist() async {
  foods = await gettask() ?? [];
  Length = foods.length;
  // print(foods);
}
