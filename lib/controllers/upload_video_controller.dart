import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:tik_tok_clone/constants.dart';
import 'package:video_compress/video_compress.dart';
import 'dart:io';
import '../models/video_model.dart' as vid;

class UploadVideoController extends GetxController {


  _compressVideo(String videoPath) async {
    final compressedVideo = await VideoCompress.compressVideo(
        videoPath, quality: VideoQuality.MediumQuality);
    print("video compress hogai hy");
    return compressedVideo?.file;
  }

  _uploadVideoToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child("videos").child(id);

    UploadTask uploadTask = ref.putFile(File(videoPath));
    TaskSnapshot snapshot = await uploadTask;
    String downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
  }

  _uploadImageToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child("thumbnails").child(id);
    UploadTask uploadTask = ref.putFile(await _getThumbnail(videoPath));
    TaskSnapshot snapshot = await uploadTask;
    String downloadImageURL = await snapshot.ref.getDownloadURL();
    return downloadImageURL;
  }

  _getThumbnail(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

  UploadVideo(
      {required String songName, required String caption, required String videoPath}) async {
    try {
      print("uid ja rhi hy");
      String uid = firebaseAuth.currentUser!.uid;
      print(uid.toString());
      DocumentSnapshot userDoc = await fireStore.collection("users")
          .doc(uid)
          .get();
      print("uid a gai hy hy");
      var allDocs = await fireStore.collection("videos").get();
      int length = allDocs.docs.length;
      String URL = await _uploadVideoToStorage("Video $length", videoPath);
      String thumbnail = await _uploadImageToStorage(
          "Video $length", videoPath);
      vid.Video video1 = vid.Video(
          userName: (userDoc.data() as Map<String, dynamic>)['name'],
          uid: uid,
          id: "Video $length",
          likes: [],
          commentCount: 0,
          shareCount: 0.toString(),
          songName: songName,
          caption: caption,
          videoURL: URL,
          thumbnail: thumbnail,
          profilePhoto: (userDoc.data() as Map<String, dynamic>)['profilePhoto'],
      );

      await fireStore.collection("videos").doc('Video $length').set(video1.toJason());
      print("ab back jana hy");
      Get.back();
    } catch (e) {
      Get.snackbar("Error Uploading Video", "${e.toString()}");
    }
  }

}