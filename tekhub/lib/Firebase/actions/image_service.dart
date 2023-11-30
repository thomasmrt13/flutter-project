import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ImageService {
  final firebase_storage.FirebaseStorage _storage =
      firebase_storage.FirebaseStorage.instance;

  Future<String?> addImage(File imageFile) async {
    try {
      Uint8List bytes = await imageFile.readAsBytes();
      return await _uploadImageToStorage(bytes);
    } catch (e) {
      print('Error adding image: $e');
      return null; // Return null if image adding fails
    }
  }

  Future<String?> _uploadImageToStorage(Uint8List imageData) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final firebase_storage.Reference reference =
          _storage.ref().child('images/$fileName.jpg');

      await reference.putData(imageData);

      String imageUrl = await reference.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null; // Return null if image uploading fails
    }
  }

  Future<String?> getImage(String imageUrl) async {
    try {
      // Download the image from Firebase Storage based on the provided URL
      firebase_storage.Reference reference = _storage.refFromURL(imageUrl);
      final Uint8List? data = await reference.getData();

      if (data != null) {
        // Convert the Uint8List to a non-nullable list before encoding to base64
        List<int> imageData = data.cast<int>();

        // For demonstration purposes, you can return the image data as a base64 string
        return 'data:image/jpeg;base64,${base64.encode(imageData)}';
      } else {
        return null; // Return null if image data is null
      }
    } catch (e) {
      print('Error getting image: $e');
      return null; // Return null if image retrieval fails
    }
  }

  Future<String?> pickAndAddImage() async {
    if (kIsWeb) {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.image);

      if (result != null && result.files.isNotEmpty) {
        File imageFile = File(result.files.first.path!);
        return await addImage(imageFile);
      }
    } else {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );

      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);
        return await addImage(imageFile);
      }
    }

    return null; // Return null if image picking or adding is unsuccessful
  }
}
