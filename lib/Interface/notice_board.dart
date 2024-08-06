import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NoticeBoardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Feed'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot post = snapshot.data!.docs[index];
              Map<String, dynamic>? data = post.data() as Map<String, dynamic>?;

              if (data == null) {
                return ListTile(
                  title: Text('Error: Missing data'),
                );
              }

              String imageUrl = data['imageURL'] ?? '';
              String userId = data['userId'] ?? 'Unknown user';
              Timestamp? timestamp = data['timestamp'];
              String description =
                  data['description'] ?? 'No description available';

              return Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Card(
                  color: Theme.of(context).colorScheme.primary,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          description,
                          style: TextStyle(),
                        ),
                        const SizedBox(height: 10),
                        ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(imageUrl)),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
