// import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/foundation.dart';
//
// class FileUploader {
//   // Private constructor for singleton pattern
//   FileUploader._privateConstructor();
//
//   // Static instance to be shared
//   static final FileUploader _instance = FileUploader._privateConstructor();
//
//   // Factory constructor that returns the same instance every time
//   factory FileUploader() {
//     return _instance;
//   }
//
//   final FirebaseStorage _storage = FirebaseStorage.instance;
//
//   Future<String> uploadSingleFile({
//     required String imageName,
//     required File file,
//     required String folderName,
//   }) async {
//     try {
//       final ref = _storage.ref("$folderName/$imageName");
//       final snapshot = await ref.putFile(file).whenComplete(() {});
//       final imageUrl = await snapshot.ref.getDownloadURL();
//
//       debugPrint("File uploaded successfully: $imageUrl");
//       return imageUrl;
//     } catch (e) {
//       debugPrint("File upload failed: $e");
//       throw 'File upload failed';
//     }
//   }
//
//   Future<List<String>> uploadMultipleFiles({
//     required String bucketName,
//     required List<File> files,
//     required String folderName,
//   }) async {
//     List<String> uploadedUrls = [];
//
//     try {
//       for (var file in files) {
//         final imageUrl = await uploadSingleFile(
//           imageName: "$bucketName/${file.path.split('/').last}",
//           file: file,
//           folderName: folderName,
//         );
//         uploadedUrls.add(imageUrl);
//       }
//       debugPrint("All files uploaded successfully: $uploadedUrls");
//       return uploadedUrls;
//     } catch (e) {
//       debugPrint("Multiple file upload failed: $e");
//       throw 'Multiple file upload failed';
//     }
//   }
//
//   Future<void> deleteImage(String urlImage) async {
//     try {
//       print("urlImage = $urlImage");
//       String relativePath = extractRelativePath(urlImage);
//       print("relativePath = $relativePath");
//       Reference storageReference =
//           FirebaseStorage.instance.ref().child(relativePath);
//
//       print("here = $storageReference");
//
//       // If it exists, proceed to delete
//       await storageReference.delete();
//       debugPrint('File deleted successfully');
//     } catch (e) {
//       debugPrint('Error: $e');
//       if (e is FirebaseException) {
//         if (e.code == 'object-not-found') {
//           throw 'File not found at path: $urlImage';
//         } else if (e.code == 'unavailable') {
//           throw 'Network error or Firebase Storage temporarily unavailable.';
//         } else {
//           throw 'Error occurred while deleting file: ${e.message}';
//         }
//       } else {
//         throw 'Non-Firebase error occurred: $e';
//       }
//     }
//   }
//
//   String extractRelativePath(String fullUrl) {
//     // Define the marker for the start of the relative path
//     const startMarker = '/o/';
//
//     // Find the starting position of the relative path
//     int startIndex = fullUrl.indexOf(startMarker) + startMarker.length;
//
//     // Find the ending position before any query parameters (e.g., "?alt=media&token=...")
//     int endIndex = fullUrl.indexOf('?');
//     if (endIndex == -1) endIndex = fullUrl.length;
//
//     // Extract the relative path portion
//     String encodedRelativePath = fullUrl.substring(startIndex, endIndex);
//
//     // Decode URL-encoded characters in the path (e.g., %40 -> @, %20 -> space)
//     return Uri.decodeComponent(encodedRelativePath);
//   }
//
//
// }
