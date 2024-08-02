import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ncbae/Complain%20Management/complain.dart';
import 'package:ncbae/components/complain_container.dart';

class ComplainBox extends StatefulWidget {
  const ComplainBox({super.key});

  @override
  State<ComplainBox> createState() => _ComplainBoxState();
}

class _ComplainBoxState extends State<ComplainBox> {
  final ref = FirebaseDatabase.instance.ref('NCBAE');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: ref.onValue,
                  builder: (index, AsyncSnapshot<DatabaseEvent> snapshot) {
                    if (!snapshot.hasData) {
                      return Align(
                          alignment: const Alignment(0, 1),
                          child: CircularProgressIndicator(
                            color: Theme.of(context).colorScheme.secondary,
                          ));
                    } else {
                      Map<dynamic, dynamic> map =
                          snapshot.data?.snapshot.value as dynamic;
                      List<dynamic> list = [];
                      list.clear();
                      list = map.values.toList();
                      return ListView.builder(
                        itemCount: snapshot.data?.snapshot.children.length,
                        itemBuilder: (context, index) {
                          return ComplaintContainer(
                              title: list[index]['Complain']);
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          enableFeedback: true,
          autofocus: true,
          heroTag: 'Add Your Complaint',
          isExtended: true,
          tooltip: 'Add a Complain!',
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ComplainPage()));
          },
          child: const Icon(Icons.add)),
    );
  }
}
