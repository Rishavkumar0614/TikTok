import 'package:get/get.dart';
import 'package:tiktok/commons.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as tago;
import 'package:google_fonts/google_fonts.dart';
import 'package:tiktok/controllers/comment_controller.dart';

class MobileCommentScreen extends StatelessWidget {
  final String id;

  MobileCommentScreen({super.key, required this.id});

  final TextEditingController _commentController = TextEditingController();
  final CommentController commentController = Get.put(CommentController());

  @override
  Widget build(BuildContext context) {
    commentController.updatePostId(id);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              Expanded(
                child: Obx(
                  () {
                    return ListView.builder(
                        itemCount: commentController.comments.length,
                        itemBuilder: (context, index) {
                          final comment = commentController.comments[index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.black,
                              backgroundImage:
                                  NetworkImage(comment.profilePhoto),
                            ),
                            title: Row(
                              children: [
                                Text(
                                  "${comment.username}  ",
                                  style: GoogleFonts.ibmPlexSans(
                                    fontSize: 20,
                                    color: Colors.red[400],
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  comment.comment,
                                  style: GoogleFonts.ibmPlexSans(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Row(children: [
                              Text(
                                tago.format(
                                  comment.datePublished.toDate(),
                                ),
                                style: GoogleFonts.ibmPlexSans(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                '${comment.likes.length} likes',
                                style: GoogleFonts.ibmPlexSans(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              )
                            ]),
                            trailing: InkWell(
                              onTap: () =>
                                  commentController.likeComment(comment.id),
                              child: Icon(
                                Icons.favorite,
                                size: 25,
                                color: comment.likes
                                        .contains(authController.user.uid)
                                    ? Colors.red
                                    : Colors.white,
                              ),
                            ),
                          );
                        });
                  },
                ),
              ),
              const Divider(),
              ListTile(
                title: TextFormField(
                  controller: _commentController,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Comment',
                    labelStyle: GoogleFonts.ibmPlexSans(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: borderColor,
                      ),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: borderColor,
                      ),
                    ),
                  ),
                ),
                trailing: TextButton(
                  onPressed: () async {
                    String text = _commentController.text;
                    _commentController.clear();
                    await commentController.postComment(text);
                  },
                  child: Text(
                    'Send',
                    style: GoogleFonts.ibmPlexSans(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
