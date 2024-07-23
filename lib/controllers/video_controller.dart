import 'package:get/get.dart';
import 'package:tiktok/commons.dart';
import 'package:tiktok/models/video.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VideoController extends GetxController {
  final Rx<List<Video>> _videoList = Rx<List<Video>>([]);

  List<Video> get videoList => _videoList.value;

  @override
  void onInit() {
    super.onInit();
    _videoList.bindStream(
      firestore.collection('videos').snapshots().map(
        (QuerySnapshot query) {
          List<Video> videos = [];
          for (var videoSnap in query.docs) {
            videos.add(
              Video.fromSnap(videoSnap),
            );
          }
          return videos;
        },
      ),
    );
  }

  likeVideo(String id) async {
    DocumentSnapshot doc =
        await firebaseController.fetchDocSnapShot('videos', id);
    var uid = authController.user.uid;
    if ((doc.data()! as dynamic)['likes'].contains(uid)) {
      await firebaseController.updateData('videos', id, {
        'likes': FieldValue.arrayRemove([uid]),
      });
    } else {
      await firebaseController.updateData('videos', id, {
        'likes': FieldValue.arrayUnion([uid]),
      });
    }
  }
}
