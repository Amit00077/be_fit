import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:workout_timer_app/constants/color.dart';
import 'package:workout_timer_app/constants/page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void _signOut() {
    FirebaseAuth.instance.signOut();
    // User? user = FirebaseAuth.instance.currentUser;
  }

  void naviagtiontapped(int page) {
    pageController.jumpToPage(page);
  }

  void pagechanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: appbarcolor,
          title: const Text("Be Fit",
              style: TextStyle(color: Colors.white, fontSize: 25)),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  _signOut();
                },
                icon: const Icon(
                  Icons.logout_outlined,
                  color: Colors.white,
                ))
          ],
        ),
        body: PageView(
          children: homeScreenItems,
          controller: pageController,
          onPageChanged: pagechanged,
        ),
        bottomNavigationBar: CupertinoTabBar(
          backgroundColor: navbarcolor,
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.home,
                  color: _page == 0 ? Colors.black : Colors.white,
                ),
              ),
              label: '',
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.search,
                  color: _page == 1 ? Colors.black : Colors.white,
                ),
              ),
              label: '',
              backgroundColor: Colors.white,
            ),
          ],
          onTap: naviagtiontapped,
        ),
      ),
    );
  }
}
