import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tik_tok_clone/constants.dart';
import 'package:tik_tok_clone/models/comment.dart';

class CommentController extends GetxController {
  final Rx<List<Comment>> _comment = Rx<List<Comment>>([]);

  List<Comment> get comments => _comment.value;

  String _postId = '';

  updatePostId(String id) {
    _postId = id;
    getComment();
  }

  getComment() async {
    _comment.bindStream(
      fireStore
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .snapshots()
          .map(
        (QuerySnapshot query) {
          List<Comment> retValue = [];
          for (var element in query.docs) {
            retValue.add(Comment.fromSnap(element));
          }
          return retValue;
        },
      ),
    );
  }

  Future postComment(String commentText) async {
    try {
      if (commentText.isNotEmpty) {
        DocumentSnapshot userDoc = await fireStore
            .collection('users')
            .doc(authController.user.uid)
            .get();
        var allDocs = await fireStore
            .collection('videos')
            .doc(_postId)
            .collection('comments')
            .get();
        int length = allDocs.docs.length;

        Comment comment = Comment(
          userName: (userDoc.data()! as dynamic)['name'],
          comment: commentText.trim(),
          datePublished: DateTime.now(),
          likes: [],
          profilePhoto: (userDoc.data()! as dynamic)['profilePhoto'],
          uid: authController.user.uid,
          id: 'comment $length',
        );

        await fireStore
            .collection('videos')
            .doc(_postId)
            .collection('comments')
            .doc('comment $length')
            .set(comment.toJson());

        DocumentSnapshot doc =
            await fireStore.collection('videos').doc(_postId).get();
        await fireStore.collection('videos').doc(_postId).update({
          'commentCount': (doc.data()! as dynamic)['commentCount'] + 1,
        });
      }
      ;
    } catch (e) {
      Get.snackbar("Error", '$e');
    }
  }

  likeComment(String id) async {
    print(id);
    var uid = authController.user.uid;
    DocumentSnapshot doc = await fireStore
        .collection('videos')
        .doc(_postId)
        .collection('comments')
        .doc(id)
        .get();

    if ((doc.data()! as dynamic)['likes'].contains(uid)) {
      await fireStore
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .doc(id)
          .update({
        'likes': FieldValue.arrayRemove([uid]),
      });
    } else {
      await fireStore
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
