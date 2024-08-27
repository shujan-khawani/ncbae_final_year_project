// ignore_for_file: avoid_print, deprecated_member_use
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ncbae/Components/reusable_row.dart';

import '../Utilities/utils.dart';

class ApplicantsPage extends StatefulWidget {
  const ApplicantsPage({super.key});

  @override
  State<ApplicantsPage> createState() => _ApplicantsPageState();
}

class _ApplicantsPageState extends State<ApplicantsPage> {
  //  loading variable
  bool loading = false;

  //  function to delete the applicant
  Future<void> _deletePost(String studentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('students')
          .doc(studentId)
          .delete();
      print('Applicant Denied successfully');
      Utils().toastMessage('Applicant Denied Successfully');
    } catch (e) {
      print('Error deleting post: $e');
      // Handle the error, e.g., show an error message to the user
      Utils().toastMessage(e.toString());
    }
  }

  //  reference for firebase authentication
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'Applicants'.toUpperCase(),
          style: const TextStyle(
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('students')
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
          } else if (!snapshot.hasData) {
            return Align(
              alignment: Alignment.center,
              child: Text(
                'Not Even a Single Applicant has Applied to University Yet!',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            );
          } else {
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
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Image.network(document['imageUrl'])),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * .01),
                        ReusableRow(
                          title: 'First Name:',
                          subtitle: document['firstName'],
                        ),
                        ReusableRow(
                          title: 'Last Name:',
                          subtitle: document['lastName'],
                        ),
                        ReusableRow(
                          title: 'Guardian\'s Name:',
                          subtitle: document['guardianName'],
                        ),
                        ReusableRow(
                          title: 'Guardian\'s Occupation:',
                          subtitle: document['guardianOccupation'],
                        ),
                        ReusableRow(
                          title: 'CNIC:',
                          subtitle: document['cnicNumber'],
                        ),
                        ReusableRow(
                          title: 'City of Residence:',
                          subtitle: document['city'],
                        ),
                        ReusableRow(
                          title: 'Contact Number:',
                          subtitle: document['contactNumber'],
                        ),
                        ReusableRow(
                          title: 'Email:',
                          subtitle: document['emailAddress'],
                        ),
                        ReusableRow(
                          title: 'Department of Interest:',
                          subtitle: document['departmentName'],
                        ),
                        ReusableRow(
                          title: 'Program:',
                          subtitle: document['program'],
                        ),
                        ReusableRow(
                          title: 'Percentile or CGPA:',
                          subtitle: document['percentile'],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              loading = true;
                            });
                            _deletePost(postId).then((value) {
                              setState(() {
                                loading = false;
                              });
                              Utils().toastMessage('Applicant Deleted');
                            }).onError((error, stackTrace) {
                              setState(() {
                                loading = false;
                              });
                              Utils().toastMessage(error.toString());
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: loading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : const Center(
                                      child: Text(
                                        'Delete Applicant',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
