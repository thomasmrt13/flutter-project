import 'dart:convert';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tekhub/Firebase/actions/result.dart';

class ImageService {
  final firebase_storage.FirebaseStorage _storage =
      firebase_storage.FirebaseStorage.instance;

    Future<Result<dynamic>> getImageUrl(String fileName, String folderName) async {
    try {
      final firebase_storage.Reference reference =
          _storage.ref().child('$folderName/$fileName');

      final String imageUrl = await reference.getDownloadURL();
      
      return Result<dynamic>.success(imageUrl);
    } catch (e) {
      return Result<dynamic>.failure('An unexpected error occurred.');
    }
  }

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

  Future<Result<dynamic>> getArticleImageUrl(String articleId) async {
    try {
      final firebase_storage.Reference reference =
          _storage.ref().child('articles/$articleId.jpg');

      final String imageUrl = await reference.getDownloadURL();
      return Result<dynamic>.success(imageUrl);
    } catch (e) {
      return Result<dynamic>.failure('An unexpected error occurred.');
    }
  }

  Future<Result<String>> uploadImageToStorage(
      String fileName, String folderName, Uint8List fileBytes,) async {
    try {
      // Generate a unique filename for the image
      // Create a reference to the specified folder in Firebase Storage
      await FirebaseStorage.instance.ref('$folderName/$fileName').putData(fileBytes);
      // final Reference storageReference =
      //     _storage.ref().child(folderName).putFile(imageFile) as firebase_storage.Reference;

      // Upload the image file to the specified folder
      // await storageReference.putFile(imageFile);

      // Get the download URL of the uploaded image
      // final String downloadUrl = await storageReference.getDownloadURL();

      // Return the download URL as a success result
      return Result<String>.success(fileName);
    } catch (error) {
      // Return an error result if any exception occurs during the upload
      return Result<String>.failure('Error uploading image: $error');
    }
  }

  // Future<Result<dynamic>> addImageToStorage(File imageFile) async {
  //   try {
  //     final Uint8List bytes = await imageFile.readAsBytes();
  //     return await _uploadImageToStorage(bytes);
  //   } catch (e) {
  //     return Result<dynamic>.failure(
  //         'An unexpected error occured.',); // Return null if image adding fails
  //   }
  // }

  // Future<Result<dynamic>> _uploadImageToStorage(Uint8List imageData) async {
  //   try {
  //     final String fileName = DateTime.now().millisecondsSinceEpoch.toString();
  //     final firebase_storage.Reference reference =
  //         _storage.ref().child('images/$fileName.jpg');

  //     await reference.putData(imageData);

  //     final String imageUrl = await reference.getDownloadURL();
  //     return Result<dynamic>.success(imageUrl);
  //   } catch (e) {
  //     return Result<dynamic>.failure(
  //         'An unexpected error occured.',); // Return null if image uploading fails
  //   }
  // }

  Future<Result<dynamic>> getImageFromStorage(String imageUrl) async {
    try {
      final firebase_storage.Reference reference =
          _storage.refFromURL(imageUrl);
      final Uint8List? data = await reference.getData();

      if (data != null) {
        final List<int> imageData = data.cast<int>();
        return Result<dynamic>.success(
          'data:image/jpeg;base64,${base64.encode(imageData)}',
        );
      } else {
        return Result<dynamic>.failure(
          "This file doesn't exist",
        ); // Return null if image data is null
      }
    } catch (e) {
      return Result<dynamic>.failure(
        'An unexpected error occured.',
      ); // Return null if image retrieval fails
    }
  }
}
