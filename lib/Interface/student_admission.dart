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
  //  selected item index
  String? selectedItemProgram;
  //  list for dropdown button
  final List<String> program = [
    'Bachelors',
    'Masters',
    'M-Phil',
    'Phd',
  ]; //  selected item index
  String? selectedItemDepartment;
  //  list for dropdown button
  final List<String> department = [
    'BS-Computer Science',
    'BS-Information Technology',
    'BS-Software Engineering',
    'Masters of Computer Science',
    'M-Phil in Computer Science',
    'Phd in Computer Science',
    'BS-English',
    'Business Administration',
    'BS-Mathematics',
    'BS-Economics',
    'M-Phil Economics',
    'Phd-Economics',
    'BS-Islamic Studies',
    'BS-Commerce',
    'BS-Physics',
    'BS-Statistics',
    'M-Phil Statistics',
    'Phd-Statistics',
    'MBA-1.5 Years',
    'MBA-2.5 Years',
  ];
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
      'firstName': inputController.firstNameController.text,
      'lastName': inputController.lastNameController.text,
      'guardianName': inputController.guardianNameController.text,
      'guardianOccupation': inputController.guardianOccupationController.text,
      'cnicNumber': inputController.cnicController.text,
      'city': inputController.cityController.text,
      'contactNumber': inputController.contactController.text,
      'emailAddress': inputController.stdEmailController.text,
      'program': selectedItemProgram,
      'percentile': inputController.percentileController.text,
      'timestamp': FieldValue.serverTimestamp(),
      'studentId': DateTime.now().millisecondsSinceEpoch,
      'departmentName': selectedItemDepartment,
    });

    // Clear form fields
    setState(() {
      _image = null;
      inputController.firstNameController.clear();
      inputController.cnicController.clear();
      inputController.cityController.clear();
      inputController.contactController.clear();
      inputController.stdEmailController.clear();
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
                  Utils().toastMessage('Image Selected Successfully!');
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
                    labelText: 'First Name',
                    controller: inputController.firstNameController,
                  ),
                  StudentTextField(
                    labelText: 'Last Name',
                    controller: inputController.lastNameController,
                  ),
                  StudentTextField(
                    labelText: 'Guardian\'s Name',
                    controller: inputController.guardianNameController,
                  ),
                  StudentTextField(
                    labelText: 'Guardian\'s Occupation',
                    controller: inputController.guardianOccupationController,
                  ),
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
                    labelText: 'Percentile or CGPA',
                    controller: inputController.percentileController,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: DropdownButtonFormField<String>(
                      value: selectedItemProgram,
                      items: program.map((item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedItemProgram = value;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Program Type',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: DropdownButtonFormField<String>(
                      value: selectedItemDepartment,
                      items: department.map((item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedItemDepartment = value;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Department',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
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
