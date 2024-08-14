import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:ncbae/Complain%20Management/complain.dart';
import 'package:ncbae/Components/complain_container.dart';

class ComplainBox extends StatefulWidget {
  const ComplainBox({super.key});

  @override
  State<ComplainBox> createState() => _ComplainBoxState();
}

class _ComplainBoxState extends State<ComplainBox> {
  //  realtime database instance
  final ref = FirebaseDatabase.instance.ref('NCBAE');
  //  function for pull to refresh
  Future<void> handleRefresh() async {
    return await Future.delayed(const Duration(milliseconds: 1200));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: LiquidPullToRefresh(
            showChildOpacityTransition: false,
            height: 200,
            springAnimationDurationInMilliseconds: 1200,
            borderWidth: 4.0,
            backgroundColor: Theme.of(context).colorScheme.primary,
            color: Theme.of(context).colorScheme.background,
            animSpeedFactor: 2,
            onRefresh: handleRefresh,
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
      ),
      floatingActionButton: FloatingActionButton(
          elevation: 10,
          autofocus: true,
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ComplainPage()));
          },
          child: const Icon(Icons.add)),
    );
  }
}
