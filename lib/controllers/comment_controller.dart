import 'package:get/get.dart';
import 'package:tiktok/commons.dart';
import 'package:tiktok/models/comment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CommentController extends GetxController {
  final Rx<List<Comment>> _comments = Rx<List<Comment>>([]);
  List<Comment> get comments => _comments.value;

  String _postId = "";

  updatePostId(String id) {
    _postId = id;
    getComments();
  }

  getComments() async {
    _comments.bindStream(
      firestore
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .snapshots()
          .map(
        (QuerySnapshot query) {
          List<Comment> comments = [];
          for (var commentSnap in query.docs) {
            comments.add(Comment.fromSnap(commentSnap));
          }
          return comments;
        },
      ),
    );
  }

  postComment(String commentText) async {
    try {
      if (commentText.isNotEmpty) {
        DocumentSnapshot userDoc = await firebaseController.fetchDocSnapShot(
            'user_data', authController.user.uid);

        var allDocs = await firestore
            .collection('videos')
            .doc(_postId)
            .collection('comments')
            .get();

        int len = allDocs.docs.length;

        Comment comment = Comment(
          likes: [],
          id: 'Comment $len',
          comment: commentText.trim(),
          uid: authController.user.uid,
          datePublished: DateTime.now(),
          username: (userDoc.data()! as dynamic)['name'],
          profilePhoto: (userDoc.data()! as dynamic)['profilePhoto'],
        );

        await firestore
            .collection('videos')
            .doc(_postId)
            .collection('comments')
            .doc('Comment $len')
            .set(comment.toJson());

        DocumentSnapshot doc =
            await firebaseController.fetchDocSnapShot('videos', _postId);
        await firebaseController.updateData('videos', _postId,
            {'commentCount': ((doc.data()! as dynamic)['commentCount'] + 1)});
      } else {
        Get.snackbar('Error While Commenting', 'Please Fill Comment Box');
      }
    } catch (e) {
      Get.snackbar(
        'Error While Commenting',
        e.toString(),
      );
    }
  }

  likeComment(String id) async {
    var uid = authController.user.uid;
    DocumentSnapshot doc = await firestore
        .collection('videos')
        .doc(_postId)
        .collection('comments')
        .doc(id)
        .get();

    if ((doc.data()! as dynamic)['likes'].contains(uid)) {
      await firestore
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .doc(id)
          .update({
        'likes': FieldValue.arrayRemove([uid]),
      });
    } else {
      await firestore
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .doc(id)
          .update({
        'likes': FieldValue.arrayUnion([uid]),
      });
    }
  }
}
