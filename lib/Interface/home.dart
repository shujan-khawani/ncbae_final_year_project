import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:ncbae/Authentication/login_page.dart';
import 'package:ncbae/Complain%20Management/complain_box.dart';
import 'package:ncbae/Interface/notice_board.dart';
import 'package:ncbae/Interface/profile.dart';
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
      drawer: Drawer(
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        child: SafeArea(
          child: Column(
            children: [
              const DrawerHeader(
                child: Image(
                  image: AssetImage('images/NCBAE LOGO.png'),
                ),
              ),
              const Spacer(),
              const Divider(),
              ListTile(
                minVerticalPadding: 30,
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
                leading: const Icon(Icons.logout),
                title: const Text('Good Bye! See Ya!'),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 10,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('N C B A & E'),
        centerTitle: true,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
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
                text: 'Feed',
                backgroundColor: Colors.transparent,
              ),
              GButton(
                icon: Icons.message_outlined,
                text: 'Complaints',
                backgroundColor: Colors.transparent,
              ),
              GButton(
                icon: Icons.document_scanner_outlined,
                text: 'Admission',
                backgroundColor: Colors.transparent,
              ),
              GButton(
                icon: Icons.person,
                text: 'About',
                backgroundColor: Colors.transparent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
