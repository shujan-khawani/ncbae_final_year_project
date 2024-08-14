// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ncbae/Utilities/controller_class.dart';
import 'package:ncbae/Utilities/text_class.dart';
import 'package:ncbae/Components/my_button.dart';
import 'package:ncbae/Components/student_field.dart';

import '../Utilities/utils.dart';

class AdminPostUpload extends StatefulWidget {
  const AdminPostUpload({super.key});

  @override
  _AdminPostUploadState createState() => _AdminPostUploadState();
}

class _AdminPostUploadState extends State<AdminPostUpload> {
  //  instance for text class
  final textClass = TextClass();
  //  variables
  File? _image;
  bool loading = false;
  //  instance for input controllers
  final inputControllers = InputControllers();
  //  function to pick image from gallery
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 60);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {
      print('Image selection cancelled.');
    }
  }

  //  function to upload the post (image with description)
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
      'description': inputControllers.postDescriptionController.text,
      'timestamp': FieldValue.serverTimestamp(),
      'postId': DateTime.now().millisecondsSinceEpoch,
    });

    // Clear form fields
    setState(() {
      _image = null;
      inputControllers.postDescriptionController.clear();
    });
  }

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
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  // Image preview
                  GestureDetector(
                    onTap: () {
                      _pickImage().then((value) {
                        Utils().toastMessage('Image Selected');
                      }).onError((error, stackTrace) {
                        Utils().toastMessage(error.toString());
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      child: _image != null
                          ? Image.file(_image!) // Show image if available
                          : const Icon(Icons.image),
                    ),
                  ),
                  // Placeholder for no image
                  SizedBox(height: MediaQuery.of(context).size.height * .04),
                  StudentTextField(
                      labelText: 'What\'s on your Mind?',
                      controller: inputControllers.postDescriptionController),
                  SizedBox(height: MediaQuery.of(context).size.height * .01),
                  MyButton(
                    buttontext: 'UPLOAD',
                    onTap: () {
                      setState(() {
                        loading = true;
                      });
                      _uploadPost().then((value) {
                        setState(() {
                          loading = false;
                        });
                        Utils().toastMessage('Post Uploaded');
                      }).onError((error, stackTrace) {
                        setState(() {
                          loading = false;
                        });
                        Utils().toastMessage(error.toString());
                      });
                    },
                    loading: loading,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .04),

                  Center(child: Text(textClass.note)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
