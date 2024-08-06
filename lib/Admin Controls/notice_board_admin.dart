import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NewsFeedScreen extends StatelessWidget {
  Future<void> deletePost(String imageUrl, String documentId) async {
    // Check if user is authenticated
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("User is not authenticated");
      return;
    }

    try {
      // Delete image file from Firebase Storage
      Reference storageReference =
          FirebaseStorage.instance.refFromURL(imageUrl);
      await storageReference.delete();

      // Delete Firestore document
      await FirebaseFirestore.instance
          .collection('posts')
          .doc(documentId)
          .delete();

      print("Post deleted successfully");
    } catch (e) {
      print("Error deleting post: $e");
    }
  }

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

              return ListTile(
                leading: Image.network(imageUrl),
                title: Text('User: $userId'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Description: $description'),
                    Text(
                        'Posted at: ${timestamp != null ? timestamp.toDate() : 'Unknown time'}'),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    await deletePost(imageUrl, post.id);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
