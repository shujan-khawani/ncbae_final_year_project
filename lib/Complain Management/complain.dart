import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
import 'package:ncbae/Utilities/utils.dart';

class ComplainPage extends StatefulWidget {
  const ComplainPage({super.key});

  @override
  State<ComplainPage> createState() => _ComplainPageState();
}

class _ComplainPageState extends State<ComplainPage> {
  final complainController = TextEditingController();
  final ref = FirebaseDatabase.instance.ref('NCBAE');
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.message_outlined,
                  size: 60,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 20),
                const Text('Enter a Complain! Anonymously'),
                const SizedBox(height: 30),
                TextField(
                  controller: complainController,
                  minLines: 4,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      loading = true;
                    });
                    String id =
                        DateTime.now().millisecondsSinceEpoch.toString();
                    ref.child(id).set({
                      'Complain': complainController.text.toString(),
                      'ID': id,
                    }).then((value) {
                      setState(() {
                        loading = false;
                        complainController.clear();
                      });
                      Utils().toastMessage('Complaint Added Successfully!');
                    }).onError((error, stackTrace) {
                      setState(() {
                        loading = false;
                      });
                      Utils().toastMessage(error.toString());
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: loading
                        ? CircularProgressIndicator(
                            color: Theme.of(context).colorScheme.secondary,
                          )
                        : const Center(child: Text('Post')),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
