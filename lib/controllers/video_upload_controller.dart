import 'package:get/get.dart';
import 'package:tiktok/commons.dart';
import 'package:tiktok/models/video.dart';
import 'package:video_compress/video_compress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VideoUploadController extends GetxController {
  _compressVideo(String videoPath) async {
    final compressedVideo = await VideoCompress.compressVideo(
      videoPath,
      quality: VideoQuality.MediumQuality,
    );
    return compressedVideo!.file;
  }

  _getThumbnail(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

  uploadVideo(String songName, String caption, String videoPath) async {
    try {
      String uid = firebaseAuth.currentUser!.uid;
      DocumentSnapshot userDoc =
          await firebaseController.fetchDocSnapShot('user_data', uid);
      var allDocs = await firebaseController.fetchColSnapShot('videos');
      int len = allDocs.docs.length;
      String videoUrl = await firebaseController.uploadFile(
          await _compressVideo(videoPath),
          firebaseStorage.ref().child('videos').child("Video $len"));
      String thumbnailUrl = await firebaseController.uploadFile(
          await _getThumbnail(videoPath),
          firebaseStorage.ref().child('thumbnails').child("Video $len"));

      Video video = Video(
        uid: uid,
        likes: [],
        shareCount: 0,
        commentCount: 0,
        caption: caption,
        id: "Video $len",
        songName: songName,
        videoUrl: videoUrl,
        thumbnailUrl: thumbnailUrl,
        username: (userDoc.data()! as Map<String, dynamic>)['username'],
        profilePhoto: (userDoc.data()! as Map<String, dynamic>)['profilePhoto'],
      );

      await firebaseController.uploadData(
          'videos', "Video $len", video.toJson());
      Get.back();
    } catch (e) {
      Get.snackbar(
        'Error Uploading Video',
        e.toString(),
      );
    }
  }
}
