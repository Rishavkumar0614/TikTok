import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String id;
  String uid;
  List likes;
  String comment;
  String username;
  String profilePhoto;
  final dynamic datePublished;

  Comment({
    required this.id,
    required this.uid,
    required this.likes,
    required this.comment,
    required this.username,
    required this.profilePhoto,
    required this.datePublished,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'uid': uid,
        'likes': likes,
        'comment': comment,
        'username': username,
        'profilePhoto': profilePhoto,
        'datePublished': datePublished,
      };

  static Comment fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Comment(
      id: snapshot['id'],
      uid: snapshot['uid'],
      likes: snapshot['likes'],
      comment: snapshot['comment'],
      username: snapshot['username'],
      profilePhoto: snapshot['profilePhoto'],
      datePublished: snapshot['datePublished'],
    );
  }
}
