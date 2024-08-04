import 'package:flutter/material.dart';

class NoticeBoardAdmin extends StatefulWidget {
  const NoticeBoardAdmin({super.key});

  @override
  State<NoticeBoardAdmin> createState() => _NoticeBoardAdminState();
}

class _NoticeBoardAdminState extends State<NoticeBoardAdmin> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Notice Board Admin Page')),
    );
  }
}
