import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  static final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  static Future<String?> uploadImageToFirebase(File? image) async {
    String? imageUrl;

    if (image == null) return null;

    try {
      final storageRef = _firebaseStorage.ref();

      // Generate a unique filename for the image
      final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final filename = 'profile_$timestamp.jpg';

      // Upload the file to the storage bucket
      final uploadTask = storageRef.child(filename).putFile(image);

      // Wait for the upload to complete
      final snapshot = await uploadTask.whenComplete(() {});

      // Get the public download URL for the uploaded image
      imageUrl = await snapshot.ref.getDownloadURL();

      // Do something with the imageUrl (save it to Firebase Firestore, display it in your app, etc.)
      print('Image uploaded successfully. Download URL: $imageUrl');
    } catch (error) {
      print('Error uploading image: $error');
    }

    return imageUrl;
  }
}
