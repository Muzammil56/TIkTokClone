import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tik_tok_clone/constants.dart';
import 'package:tik_tok_clone/models/video_model.dart';

class VideoController extends GetxController {

  final Rx<List<Video>> _videoList = Rx<List<Video>>([]);
  List<Video> get videoList => _videoList.value;

  @override
  void onInit() {
    _videoList.bindStream(fireStore.collection('videos').snapshots().map((QuerySnapshot query) {
      List<Video> returnValue = [];
      for(var element in query.docs) {
        returnValue.add(Video.fromSnap(element));
      }
      return returnValue;
    }));
    super.onInit();
  }

videoLikes(String id) async {
  print("likes waly function mai aya hy");
    DocumentSnapshot doc = await fireStore.collection('videos').doc(id).get();
    var uid = authController.user.uid;
    print(uid);
    print("UId print hui hy");
    if((doc.data()! as dynamic)['likes'].contains(uid)){
      await fireStore.collection("videos").doc(id).update({
        'likes': FieldValue.arrayRemove([uid]),
      });
    }else {
      await fireStore.collection("videos").doc(id).update({
        'likes': FieldValue.arrayUnion([uid]),
      });
    }
}

}