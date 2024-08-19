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

class StudentAdmission extends StatefulWidget {
  const StudentAdmission({super.key});

  @override
  _StudentAdmissionState createState() => _StudentAdmissionState();
}

class _StudentAdmissionState extends State<StudentAdmission> {
  //  variables
  File? _image;
  //  global form key
  final formKey = GlobalKey<FormState>();
  //  instances
  final inputController = InputControllers();
  //  function for picking the image from the gallery of the device
  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {
      print(
          'Image selection cancelled. Exception occurred Please Check Your Connection!');
    }
  }

  //  future function that uploads the information of the student along with his picture to firebase fire store
  Future<void> _uploadStudentInfo() async {
    if (_image == null) {
      return; // Prevent upload without an image
    }

    Reference ref = FirebaseStorage.instance
        .ref('STUDENTS')
        .child('students/${DateTime.now().millisecondsSinceEpoch}');
    UploadTask uploadTask = ref.putFile(_image!);
    TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
    String imageUrl = await snapshot.ref.getDownloadURL();

    // Save all student data to Firestore
    await FirebaseFirestore.instance.collection('students').add({
      'imageUrl': imageUrl,
      'name': inputController.nameController.text,
      'cnicNumber': inputController.cnicController.text,
      'city': inputController.cityController.text,
      'contactNumber': inputController.contactController.text,
      'emailAddress': inputController.stdEmailController.text,
      'department': inputController.departmentController.text,
      'percentile': inputController.percentileController.text,
      'timestamp': FieldValue.serverTimestamp(),
      'studentId': DateTime.now().millisecondsSinceEpoch,
    });

    // Clear form fields
    setState(() {
      _image = null;
      inputController.nameController.clear();
      inputController.cnicController.clear();
      inputController.cityController.clear();
      inputController.contactController.clear();
      inputController.stdEmailController.clear();
      inputController.departmentController.clear();
      inputController.percentileController.clear();
    });
  }

  final textClass = TextClass();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Image preview
            GestureDetector(
              onTap: () {
                _pickImage().then((value) {
                  Utils().toastMessage('Student Added Successfully!');
                }).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());
                });
              },
              child: Container(
                height: 180,
                width: 100,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: _image != null
                    ? Image.file(_image!) // Show image if available
                    : const Icon(Icons.image),
              ),
            ),
            // Placeholder for no image
            const SizedBox(height: 16.0),
            Form(
              key: formKey,
              child: Column(
                children: [
                  StudentTextField(
                      labelText: 'Name',
                      controller: inputController.nameController),
                  StudentTextField(
                    labelText: 'CNIC Number',
                    controller: inputController.cnicController,
                  ),
                  StudentTextField(
                    labelText: 'City of Residence',
                    controller: inputController.cityController,
                  ),
                  StudentTextField(
                    labelText: 'Contact Number',
                    controller: inputController.contactController,
                  ),
                  StudentTextField(
                    labelText: 'Email',
                    controller: inputController.stdEmailController,
                  ),
                  StudentTextField(
                    labelText: 'Department of Interest',
                    controller: inputController.departmentController,
                  ),
                  StudentTextField(
                    labelText: 'Percentile or CGPA',
                    controller: inputController.percentileController,
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .03),
            MyButton(
              buttontext: 'ADD',
              onTap: () {
                if (formKey.currentState!.validate()) {
                  setState(() {
                    loading = true;
                  });
                  _uploadStudentInfo().then((value) {
                    setState(() {
                      loading = false;
                    });
                    Utils().toastMessage('New Student Added');
                  }).onError((error, stackTrace) {
                    setState(() {
                      loading = false;
                    });
                    Utils().toastMessage(error.toString());
                  });
                }
              },
              loading: loading,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .03),

            Text(textClass.note),
          ],
        ),
      ),
    );
  }
}
