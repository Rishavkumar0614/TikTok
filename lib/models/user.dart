import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String uid;
  String name;
  String username;
  String profilePhoto;

  User(
      {required this.uid,
      required this.name,
      required this.username,
      required this.profilePhoto});

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "username": username,
        "profilePhoto": profilePhoto,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      uid: snapshot['uid'],
      name: snapshot['name'],
      username: snapshot['username'],
      profilePhoto: snapshot['profilePhoto'],
    );
  }
}
