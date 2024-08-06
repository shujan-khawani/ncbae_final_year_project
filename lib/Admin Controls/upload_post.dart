import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ncbae/Utilities/utils.dart';
import 'package:ncbae/components/my_button.dart';
import 'package:ncbae/components/my_textfield.dart';

class UploadImageScreen extends StatefulWidget {
  @override
  _UploadImageScreenState createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  File? _image;
  final picker = ImagePicker();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _descriptionController = TextEditingController();

  Future pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        Utils().toastMessage('No image selected.');
      }
    });
  }

  Future uploadImageToFirebase(BuildContext context) async {
    if (_image == null) return;
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('uploads/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(_image!);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadURL = await taskSnapshot.ref.getDownloadURL();

    // Save image URL and description to Firestore
    await FirebaseFirestore.instance.collection('posts').add({
      'imageURL': downloadURL,
      'description': _descriptionController.text,
      'userId': _auth.currentUser?.uid,
      'timestamp': FieldValue.serverTimestamp(),
    });

    // Clear the description field
    _descriptionController.clear();
  }

  //  boolean value for loading
  bool loading = false;
  bool loading2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('N C B A & E'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _image != null
                  ? Image.file(
                      _image!,
                      height: 150,
                    )
                  : const Text('No image selected.'),
              MyButton(
                buttontext: 'Choose Image',
                onTap: () {
                  setState(() {
                    loading = true;
                  });
                  pickImage().then((value) {
                    setState(() {
                      loading = false;
                    });
                  }).onError((error, stackTrace) {
                    setState(() {
                      loading = false;
                    });
                    Utils().toastMessage(error.toString());
                  });
                },
                loading: loading,
              ),
              MyTextfield(
                labelText: 'Describe Your Post',
                obscure: false,
                controller: _descriptionController,
                suffixIcon: null,
              ),
              MyButton(
                buttontext: 'Post',
                onTap: () {
                  setState(() {
                    loading2 = true;
                  });
                  uploadImageToFirebase(context).then((value) {
                    setState(() {
                      loading2 = false;
                    });
                    Utils().toastMessage('Post Added Successfully!');
                  }).onError((error, stackTrace) {
                    setState(() {
                      loading2 = false;
                    });
                    Utils().toastMessage(error.toString());
                  });
                },
                loading: loading2,
              )
            ],
          ),
        ),
      ),
    );
  }
}
