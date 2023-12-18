import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:tekhub/Firebase/actions/result.dart';

class ImageService {
  final firebase_storage.FirebaseStorage _storage =
      firebase_storage.FirebaseStorage.instance;

  Future<Result<dynamic>> getUserProfileImageUrl(String userId) async {
    try {
      final firebase_storage.Reference reference =
          _storage.ref().child('user_profiles/$userId.jpg');

      final String imageUrl = await reference.getDownloadURL();
      return Result<dynamic>.success(imageUrl);
    } catch (e) {
      return Result<dynamic>.failure('An unexpected error occurred.');
    }
  }

  Future<Result<dynamic>> addImageToStorage(File imageFile) async {
    try {
      final Uint8List bytes = await imageFile.readAsBytes();
      return await _uploadImageToStorage(bytes);
    } catch (e) {
      return Result<dynamic>.failure(
          'An unexpected error occured.'); // Return null if image adding fails
    }
  }

  Future<Result<dynamic>> _uploadImageToStorage(Uint8List imageData) async {
    try {
      final String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final firebase_storage.Reference reference =
          _storage.ref().child('images/$fileName.jpg');

      await reference.putData(imageData);

      final String imageUrl = await reference.getDownloadURL();
      return Result<dynamic>.success(imageUrl);
    } catch (e) {
      return Result<dynamic>.failure(
          'An unexpected error occured.'); // Return null if image uploading fails
    }
  }

  Future<Result<dynamic>> getImageFromStorage(String imageUrl) async {
    try {
      final firebase_storage.Reference reference =
          _storage.refFromURL(imageUrl);
      final Uint8List? data = await reference.getData();

      if (data != null) {
        final List<int> imageData = data.cast<int>();
        return Result<dynamic>.success(
            'data:image/jpeg;base64,${base64.encode(imageData)}');
      } else {
        return Result<dynamic>.failure(
            "This file doesn't exist"); // Return null if image data is null
      }
    } catch (e) {
      return Result<dynamic>.failure(
          'An unexpected error occured.'); // Return null if image retrieval fails
    }
  }
}
