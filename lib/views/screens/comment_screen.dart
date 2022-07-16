import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tik_tok_clone/constants.dart';
import '../../controllers/comment_controller.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentScreen extends StatelessWidget {
  final String id;

  CommentScreen({Key? key, required this.id}) : super(key: key);

  TextEditingController _commentController = TextEditingController();
  CommentController commentController = Get.put(CommentController());

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    commentController.updatePostId(this.id);
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              Expanded(
                child: Obx(() {
                  return ListView.builder(
                    itemCount: commentController.comments.length,
                    itemBuilder: (context, index) {
                      final comment = commentController.comments[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: backgroundColor,
                          backgroundImage:
                              NetworkImage('${comment.profilePhoto}'),
                        ),
                        title: Row(
                          children: [
                            Text(
                              comment.userName,
                              style: TextStyle(
                                fontSize: 20,
                                color: buttonColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              comment.comment,
                              style: TextStyle(
                                fontSize: 20,
                                color: white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        subtitle: Row(
                          children: [
                            Text(
                              timeago
                                  .format(comment.datePublished.toDate())
                                  .toString(),
                              style: TextStyle(
                                fontSize: 12,
                                color: white,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "${comment.likes.length} likes",
                              style: TextStyle(
                                fontSize: 10,
                                color: white,
                              ),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            commentController.likeComment(comment.id);
                          },
                          icon: Icon(
                            Icons.favorite,
                            size: 25,
                            color: comment.likes.contains(authController.user.uid) ? Colors.red : Colors.white,
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
              Divider(),
              ListTile(
                title: TextField(
                  controller: _commentController,
                  style: TextStyle(
                    fontSize: 16,
                    color: white,
                  ),
                  decoration: InputDecoration(
                    labelText: "Comment",
                    labelStyle: TextStyle(
                      fontSize: 20,
                      color: white,
                      fontWeight: FontWeight.w700,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
                trailing: TextButton(
                  onPressed: () {
                    commentController
                        .postComment(_commentController.text)
                        .whenComplete(() => {
                              FocusManager.instance.primaryFocus?.unfocus(),
                              _commentController.clear(),
                            });
                  },
                  child: Text(
                    "Send",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: white),
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
