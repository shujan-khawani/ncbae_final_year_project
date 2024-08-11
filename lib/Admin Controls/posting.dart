// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ncbae/Utilities/text_class.dart';
import 'package:ncbae/components/my_button.dart';

import '../Utilities/utils.dart';

class AdminPostUpload extends StatefulWidget {
  const AdminPostUpload({super.key});

  @override
  _AdminPostUploadState createState() => _AdminPostUploadState();
}

class _AdminPostUploadState extends State<AdminPostUpload> {
  File? _image;
  String _description = '';

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {
      print('Image selection cancelled.');
    }
  }

  Future<void> _uploadPost() async {
    if (_image == null) {
      return; // Prevent upload without an image
    }
    Reference ref = FirebaseStorage.instance
        .ref('POSTS')
        .child('posts/${DateTime.now().millisecondsSinceEpoch}');
    UploadTask uploadTask = ref.putFile(_image!);
    TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
    String imageUrl = await snapshot.ref.getDownloadURL();

    // Save post data to Fire store
    await FirebaseFirestore.instance.collection('posts').add({
      'imageUrl': imageUrl,
      'description': _description,
      'timestamp': FieldValue.serverTimestamp(),
      'postId': DateTime.now().millisecondsSinceEpoch,
    });

    // Clear form fields
    setState(() {
      _image = null;
      _description = '';
    });
  }

  final textClass = TextClass();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        elevation: 10,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'Admin Panel'.toUpperCase(),
          style: const TextStyle(
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Image preview
            GestureDetector(
              onTap: () {
                _pickImage().then((value) {
                  Utils().toastMessage('Post Uploaded');
                }).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());
                });
              },
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: _image != null
                    ? Image.file(_image!) // Show image if available
                    : const Icon(Icons.image),
              ),
            ),
            // Placeholder for no image
            const SizedBox(height: 16.0),
            TextField(
              onChanged: (value) => _description = value,
              decoration: InputDecoration(
                labelText: 'Description',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .03),
            MyButton(
              buttontext: 'UPLOAD',
              onTap: () {
                _uploadPost().then((value) {
                  Utils().toastMessage('Post Uploaded');
                }).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());
                });
              },
              loading: loading,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .02),
            Row(
              children: [
                Text(
                  'Note: \n',
                  style: TextStyle(
                    fontSize: 19,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * .06),
                Text(textClass.note),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
