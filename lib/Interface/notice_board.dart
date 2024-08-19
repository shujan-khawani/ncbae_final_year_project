// ignore_for_file: avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class NoticeBoard extends StatefulWidget {
  const NoticeBoard({super.key});

  @override
  State<NoticeBoard> createState() => _NoticeBoardState();
}

class _NoticeBoardState extends State<NoticeBoard> {
  //  function for pull to refresh
  Future<void> handleRefresh() async {
    return await Future.delayed(const Duration(milliseconds: 1200));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiquidPullToRefresh(
        showChildOpacityTransition: false,
        height: 200,
        springAnimationDurationInMilliseconds: 1200,
        borderWidth: 4.0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        color: Theme.of(context).colorScheme.background,
        animSpeedFactor: 2,
        onRefresh: handleRefresh,
        child: StreamBuilder<QuerySnapshot>(
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
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12.0, vertical: 7),
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          document['description'],
                          style: const TextStyle(
                            letterSpacing: .5,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * .02),
                        const Divider(),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Image.network(document['imageUrl']),
                        ),
                        const Divider(),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
