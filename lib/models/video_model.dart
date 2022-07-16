import 'package:cloud_firestore/cloud_firestore.dart';

class Video {
  String userName;
  String uid;
  String id;
  List likes;
  int commentCount;
  String shareCount;
  String songName;
  String caption;
  String videoURL;
  String thumbnail;
  String profilePhoto;

  Video({
    required this.userName,
    required this.uid,
    required this.id,
    required this.likes,
    required this.commentCount,
    required this.shareCount,
    required this.songName,
    required this.caption,
    required this.videoURL,
    required this.thumbnail,
    required this.profilePhoto,
  });

   Map<String, dynamic> toJason() => {
        "username": userName,
        "profilePhoto": profilePhoto,
        "id": id,
        "uid": uid,
        "likes": likes,
        "commentCount": commentCount,
        "shareCount": shareCount,
        "songName": songName,
        "caption": caption,
        "videoURL": videoURL,
        "thumbnail": thumbnail,
      };

  static Video fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Video(
      userName: snapshot["username"],
      uid: snapshot["uid"],
      id: snapshot["id"],
      likes: snapshot["likes"],
      commentCount: snapshot["commentCount"],
      shareCount: snapshot["shareCount"],
      songName: snapshot["songName"],
      caption: snapshot["caption"],
      videoURL: snapshot["videoURL"],
      thumbnail: snapshot["thumbnail"],
      profilePhoto: snapshot["profilePhoto"],
    );
  }
}
