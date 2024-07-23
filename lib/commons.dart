import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tiktok/controllers/auth_controller.dart';
import 'package:tiktok/controllers/firebase_controller.dart';
import 'package:tiktok/views/screens/mobile/video_screen.dart';
import 'package:tiktok/views/screens/mobile/search_screen.dart';
import 'package:tiktok/views/screens/mobile/add_video_screen.dart';

var pages = {
  'mobile': [
    MobileVideoScreen(),
    MobileSearchScreen(),
    const MobileAddVideoScreen(),
    Center(
      child: Text(
        'Messages Screen',
        style:
            GoogleFonts.ibmPlexSans(fontSize: 30, fontWeight: FontWeight.w800),
      ),
    ),
  ],
};

// COLORS
const borderColor = Colors.grey;
var buttonColor = Colors.red[400];
const backgroundColor = Colors.black;

// FIREBASE
var firebaseAuth = FirebaseAuth.instance;
var firestore = FirebaseFirestore.instance;
var firebaseStorage = FirebaseStorage.instance;

// CONTROLLER
var authController = AuthController.instance;
var firebaseController = FirebaseController();

Future<XFile?> pickImage() async {
  return (await ImagePicker().pickImage(source: ImageSource.gallery));
}

Future<XFile?> pickVideo(ImageSource? src) async {
  return (await ImagePicker()
      .pickVideo(source: (src != null) ? src : ImageSource.gallery));
}
