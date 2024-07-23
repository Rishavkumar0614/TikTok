import 'package:get/get.dart';
import 'package:tiktok/commons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseController {
  Future<String> uploadFile(dynamic file, Reference ref) async {
    try {
      if (firebaseAuth.currentUser != null) {
        if (file is Future) {
          file = await file;
        }
        UploadTask uploadTask = ref.putFile(file);
        TaskSnapshot snap = await uploadTask;
        String downloadUrl = await snap.ref.getDownloadURL();
        return downloadUrl;
      } else {
        Get.snackbar('Error Uploading File',
            'No User Found, First Sign In Else Sign Up');
      }
    } catch (e) {
      Get.snackbar('Error Uploading File', e.toString());
    }
    return '';
  }

  Future<dynamic> fetchDocSnapShot(
      String collectionName, String documentName) async {
    try {
      final docRef = firestore.collection(collectionName).doc(documentName);
      DocumentSnapshot docSnap = await docRef.get();
      if (docSnap.exists) {
        return docSnap;
      } else {
        throw 'Document Does Not Exists';
      }
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> fetchColSnapShot(String collectionName) async {
    try {
      final colRef = firestore.collection(collectionName);
      return (await colRef.get());
    } catch (e) {
      return e;
    }
  }

  dynamic fetchDocReference(String collectionName, String documentName) {
    try {
      return firestore.collection(collectionName).doc(documentName);
    } catch (e) {
      return e;
    }
  }

  Future<void> uploadData(String collectionName, String documentName,
      Map<String, dynamic> data) async {
    try {
      await firestore.collection(collectionName).doc(documentName).set(data);
    } catch (e) {
      Get.snackbar('Error Uploading Data', e.toString());
    }
  }

  Future<dynamic> updateData(String collectionName, String documentName,
      Map<String, dynamic> data) async {
    try {
      final docRef = firestore.collection(collectionName).doc(documentName);
      DocumentSnapshot docSnap = await docRef.get();
      if (docSnap.exists) {
        await docRef.update(data);
      } else {
        throw 'Document Does Not Exists';
      }
    } catch (e) {
      return e;
    }
  }

  dynamic fetchCollection(String collectionName) {
    try {
      return (firestore.collection(collectionName).snapshots());
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> createUser(String username, String password) async {
    try {
      return (await firebaseAuth.createUserWithEmailAndPassword(
          email: username, password: password));
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> loginUser(String username, String password) async {
    try {
      return (await firebaseAuth.signInWithEmailAndPassword(
          email: username, password: password));
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> signOut() async {
    try {
      await firebaseAuth.signOut();
      return null;
    } catch (e) {
      return e;
    }
  }
}
