import 'dart:io';
import 'package:get/get.dart';
import 'package:tiktok/commons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tiktok/models/user.dart' as model;
import 'package:tiktok/views/screens/mobile/home_screen.dart';
import 'package:tiktok/views/screens/mobile/onboarding_screen.dart';

class AuthController extends GetxController {
  late Rx<User?> _user;
  late Rx<File?> _pickedImage;
  static AuthController instance = Get.find();

  User get user => _user.value!;
  File? get profilePhoto => _pickedImage.value;

  set profilePhoto(File? file) => _pickedImage.value = file;

  @override
  void onReady() {
    super.onReady();
    _pickedImage = Rx<File?>(null);
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => const MobileOnBoardingScreen());
    } else {
      Get.offAll(() => const MobileHomeScreen());
    }
  }

  void createUser(
    String name,
    String username,
    String password,
    File? profilePhoto,
  ) async {
    try {
      if (profilePhoto != null &&
          username.isNotEmpty &&
          password.isNotEmpty &&
          name.isNotEmpty) {
        dynamic cred = await firebaseController.createUser(username, password);

        if (cred is! UserCredential) {
          throw cred;
        }

        String profilePhotoUrl = await firebaseController.uploadFile(
            profilePhoto,
            firebaseStorage.ref().child(firebaseAuth.currentUser!.uid));

        model.User user = model.User(
          name: name,
          username: username,
          uid: cred.user!.uid,
          profilePhoto: profilePhotoUrl,
        );

        await firebaseController.uploadData(
            'user_data', cred.user!.uid, user.toJson());
      } else {
        Get.snackbar(
          'Error Creating Account',
          'Please Enter All The Details',
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error Creating Account',
        e.toString(),
      );
    }
  }

  void loginUser(String username, String password) async {
    try {
      if (username.isNotEmpty && password.isNotEmpty) {
        dynamic cred = await firebaseController.loginUser(username, password);
        if (cred is! UserCredential) {
          throw cred;
        }
      } else {
        Get.snackbar(
          'Error Logging in',
          'Please Enter All The Details',
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error Logging in',
        e.toString(),
      );
    }
  }

  void signOut() async {
    try {
      dynamic res = await firebaseController.signOut();
      if (res != null) {
        throw res;
      }
    } catch (e) {
      Get.snackbar('Error Signing Out', e.toString());
    }
  }
}
