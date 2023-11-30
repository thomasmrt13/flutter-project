import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ImageService {
  final firebase_storage.FirebaseStorage _storage =
      firebase_storage.FirebaseStorage.instance;

  Future<String?> addImageToStorage(File imageFile) async {
    try {
      Uint8List bytes = await imageFile.readAsBytes();
      return await _uploadImageToStorage(bytes);
    } catch (e) {
      print('Error adding image to storage: $e');
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
      print('Error uploading image to storage: $e');
      return null; // Return null if image uploading fails
    }
  }

  Future<String?> getImageFromStorage(String imageUrl) async {
    try {
      firebase_storage.Reference reference = _storage.refFromURL(imageUrl);
      final Uint8List? data = await reference.getData();

      if (data != null) {
        List<int> imageData = data.cast<int>();
        return 'data:image/jpeg;base64,${base64.encode(imageData)}';
      } else {
        return null; // Return null if image data is null
      }
    } catch (e) {
      print('Error getting image from storage: $e');
      return null; // Return null if image retrieval fails
    }
  }
}
