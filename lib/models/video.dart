import 'package:cloud_firestore/cloud_firestore.dart';

class Video {
  String id;
  String uid;
  List likes;
  int shareCount;
  String caption;
  String videoUrl;
  String songName;
  String username;
  int commentCount;
  String thumbnailUrl;
  String profilePhoto;

  Video({
    required this.id,
    required this.uid,
    required this.likes,
    required this.caption,
    required this.videoUrl,
    required this.songName,
    required this.username,
    required this.shareCount,
    required this.commentCount,
    required this.thumbnailUrl,
    required this.profilePhoto,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "uid": uid,
        "likes": likes,
        "caption": caption,
        "videoUrl": videoUrl,
        "username": username,
        "songName": songName,
        "shareCount": shareCount,
        "thumbnailUrl": thumbnailUrl,
        "commentCount": commentCount,
        "profilePhoto": profilePhoto,
      };

  static Video fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Video(
      id: snapshot["id"],
      uid: snapshot["uid"],
      likes: snapshot["likes"],
      caption: snapshot["caption"],
      videoUrl: snapshot["videoUrl"],
      songName: snapshot["songName"],
      username: snapshot["username"],
      shareCount: snapshot["shareCount"],
      commentCount: snapshot["commentCount"],
      thumbnailUrl: snapshot["thumbnailUrl"],
      profilePhoto: snapshot["profilePhoto"],
    );
  }
}
