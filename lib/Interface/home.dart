import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:ncbae/Complain%20Management/complain_box.dart';
import 'package:ncbae/Interface/notice_board.dart';
import 'package:ncbae/Interface/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late PageController _pageController;

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
          const NoticeBoardPage(),
          const ComplainBox(),
          ProfilePage(),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        child: const Column(
          children: [],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: GNav(
            gap: 12,
            backgroundColor: Theme.of(context).colorScheme.primary,
            tabBackgroundColor: Theme.of(context).colorScheme.secondary,
            activeColor: Theme.of(context).colorScheme.background,
            selectedIndex: _selectedIndex,
            onTabChange: _onNavBarTapped,
            tabs: const [
              GButton(
                icon: Icons.add_alert,
                text: 'Notice Board',
                backgroundColor: Colors.transparent,
              ),
              GButton(
                icon: Icons.message_outlined,
                text: 'Complaint Box',
                backgroundColor: Colors.transparent,
              ),
              GButton(
                icon: Icons.person,
                text: 'Profile',
                backgroundColor: Colors.transparent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
