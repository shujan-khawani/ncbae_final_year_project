import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadPost extends StatefulWidget {
  const UploadPost({super.key});

  @override
  _UploadPostState createState() => _UploadPostState();
}

class _UploadPostState extends State<UploadPost> {
  final _descriptionController = TextEditingController();
  XFile? _image;
  final ImagePicker _picker = ImagePicker();

  bool _isLoading = false; // Flag to indicate upload progress

  Future<void> _pickImage() async {
    try {
      final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          _image = pickedImage;
        });
      }
    } catch (e) {
      // Handle image picking errors
      print('Error picking image: $e');
    }
  }

  Future<void> _uploadPost() async {
    setState(() {
      _isLoading = true;
    });

    try {
      if (_image != null && _descriptionController.text.isNotEmpty) {
        // Compress image (optional)
        // ...

        // Upload image to Firebase Storage
        final storageRef =
            FirebaseStorage.instance.ref().child('posts/${_image!.name}');
        final uploadTask = await storageRef.putFile(File(_image!.path));
        final imageUrl = await uploadTask.ref.getDownloadURL();

        // Save post data to Firestore
        await FirebaseFirestore.instance.collection('posts').add({
          'imageUrl': imageUrl,
          'description': _descriptionController.text,
          'createdAt': Timestamp.now(),
        });

        // Clear fields
        _descriptionController.clear();
        setState(() {
          _image = null;
        });
      }
    } catch (e) {
      // Handle upload errors
      print('Error uploading post: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Post')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 16.0),
            _image != null
                ? Image.file(File(_image!.path))
                : const Text('No image selected.'),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Pick Image'),
            ),
            ElevatedButton(
              onPressed: _isLoading ? null : _uploadPost,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Upload Post'),
            ),
          ],
        ),
      ),
    );
  }
}
