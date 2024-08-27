// ignore_for_file: avoid_print, deprecated_member_use
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ncbae/Admin%20Controls/applicants.dart';
import 'package:ncbae/Admin%20Controls/posting.dart';
import 'package:ncbae/Authentication/login_page.dart';

import '../Utilities/utils.dart';

class AdminPost extends StatefulWidget {
  const AdminPost({super.key});

  @override
  State<AdminPost> createState() => _AdminPostState();
}

class _AdminPostState extends State<AdminPost> {
  Future<void> _deletePost(String postId) async {
    try {
      await FirebaseFirestore.instance.collection('posts').doc(postId).delete();
      print('Post deleted successfully');
      Utils().toastMessage('Post Deleted Successfully');
    } catch (e) {
      print('Error deleting post: $e');
      // Handle the error, e.g., show an error message to the user
      Utils().toastMessage(e.toString());
    }
  }

  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        // end drawer
        endDrawer: Drawer(
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
                ListTile(
                  minVerticalPadding: 30,
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ApplicantsPage()));
                  },
                  leading: const Icon(Icons.document_scanner_outlined),
                  title: const Text('Applicants for Admissions'),
                ),
                const Divider(),
                ListTile(
                  minVerticalPadding: 30,
                  onTap: () {
                    auth.signOut().then((value) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                      Utils().toastMessage('Signed Out Successfully!');
                    }).onError((error, stackTrace) {
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

        //  app bar
        appBar: AppBar(
          elevation: 10,
          backgroundColor: Theme.of(context).colorScheme.primary,
          automaticallyImplyLeading: false,
          title: Text(
            'Admin Panel'.toUpperCase(),
            style: const TextStyle(
              letterSpacing: 2,
            ),
          ),
          centerTitle: true,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('posts')
              .orderBy('timestamp', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator());
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = snapshot.data!.docs[index];
                String postId =
                    document.id; // Get the post ID from the document

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: ListTile(
                      leading: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.network(document['imageUrl'])),
                      title: Text(document['description']),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          _deletePost(postId).then((value) {
                            Utils().toastMessage('Post Deleted');
                          }).onError((error, stackTrace) {
                            Utils().toastMessage(error.toString());
                          }); // Pass the postId as an argument
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AdminPostUpload()));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
