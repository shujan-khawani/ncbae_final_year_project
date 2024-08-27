// ignore_for_file: deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:ncbae/Authentication/login_page.dart';
import 'package:ncbae/Complain%20Management/complain_box.dart';
import 'package:ncbae/Interface/notice_board.dart';
import 'package:ncbae/Interface/about.dart';
import 'package:ncbae/Interface/student_admission.dart';
import 'package:ncbae/Utilities/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late PageController _pageController;
  final auth = FirebaseAuth.instance;
  bool loading = false;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onNavBarTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: <Widget>[
          const NoticeBoard(),
          const ComplainBox(),
          const StudentAdmission(),
          AboutPage(),
        ],
      ),
      appBar: AppBar(
        elevation: 10,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('N C B A & E'),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(9),
          child: GestureDetector(
            onTap: () {
              Utils().toastMessage('Happy Easter!');
            },
            child: const Image(
              image: AssetImage('images/NCBAE LOGO.png'),
            ),
          ),
        ),
        foregroundColor: Theme.of(context).colorScheme.secondary,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  loading = true;
                });
                auth.signOut().then((value) {
                  setState(() {
                    loading = false;
                  });
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const LoginPage()));
                  Utils().toastMessage('Signed Out Successfully!');
                }).onError((error, stackTrace) {
                  setState(() {
                    loading = false;
                  });
                  Utils().toastMessage(error.toString());
                });
              },
              child: const Icon(
                CupertinoIcons.arrow_uturn_left,
                size: 22,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: GNav(
        gap: 8,
        backgroundColor: Theme.of(context).colorScheme.primary,
        tabBackgroundColor: Theme.of(context).colorScheme.secondary,
        activeColor: Colors.black,
        selectedIndex: _selectedIndex,
        onTabChange: _onNavBarTapped,
        tabs: const [
          GButton(
            icon: CupertinoIcons.news,
            text: 'Feed',
            backgroundColor: Colors.transparent,
          ),
          GButton(
            icon: CupertinoIcons.text_bubble,
            text: 'Complaints',
            backgroundColor: Colors.transparent,
          ),
          GButton(
            icon: CupertinoIcons.doc_richtext,
            text: 'Register',
            backgroundColor: Colors.transparent,
          ),
          GButton(
            icon: CupertinoIcons.person_3,
            text: 'About',
            backgroundColor: Colors.transparent,
          ),
        ],
      ),
    );
  }
}
