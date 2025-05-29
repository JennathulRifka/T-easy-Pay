import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Get user profile data
  Future<Map<String, dynamic>?> getUserProfile() async {
    try {
      if (currentUser != null) {
        final doc =
            await _firestore.collection('users').doc(currentUser!.uid).get();
        return doc.data();
      }
      return null;
    } catch (e) {
      print('Error getting user profile: $e');
      return null;
    }
  }

  // Update user profile
  Future<bool> updateUserProfile({
    required String fullName,
    required String userName,
    required String email,
    required String address,
    required String mobile,
    File? profileImage,
  }) async {
    try {
      if (currentUser == null) return false;

      String? imageUrl;
      if (profileImage != null) {
        // Upload profile image
        final ref = _storage.ref().child('profile_images/${currentUser!.uid}');
        await ref.putFile(profileImage);
        imageUrl = await ref.getDownloadURL();
      }

      // Update email if changed
      if (email != currentUser!.email) {
        await currentUser!.updateEmail(email);
      }

      // Update profile data in Firestore
      await _firestore.collection('users').doc(currentUser!.uid).set({
        'fullName': fullName,
        'userName': userName,
        'email': email,
        'address': address,
        'mobile': mobile,
        'profileImage': imageUrl,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      return true;
    } catch (e) {
      print('Error updating profile: $e');
      return false;
    }
  }

  // Update password
  Future<bool> updatePassword(String newPassword) async {
    try {
      if (currentUser == null) return false;
      await currentUser!.updatePassword(newPassword);
      return true;
    } catch (e) {
      print('Error updating password: $e');
      return false;
    }
  }

  // Upload profile image
  Future<String?> uploadProfileImage(File imageFile) async {
    try {
      if (currentUser == null) return null;

      final ref = _storage.ref().child('profile_images/${currentUser!.uid}');
      await ref.putFile(imageFile);
      return await ref.getDownloadURL();
    } catch (e) {
      print('Error uploading profile image: $e');
      return null;
    }
  }
}
