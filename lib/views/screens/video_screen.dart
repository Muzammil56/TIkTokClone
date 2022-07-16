import 'package:flutter/material.dart';
import 'package:tik_tok_clone/constants.dart';
import 'package:tik_tok_clone/views/screens/comment_screen.dart';
import 'package:tik_tok_clone/views/widgets/circle_animation.dart';
import 'package:tik_tok_clone/views/widgets/video_player_item.dart';
import 'package:get/get.dart';
import '../../controllers/video_controller.dart';

class VideoScreen extends StatelessWidget {
  VideoScreen({Key? key}) : super(key: key);

  final VideoController _videoController = Get.put(VideoController());

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Obx(() {
          return PageView.builder(
            itemCount: _videoController.videoList.length,
            controller: PageController(initialPage: 0, viewportFraction: 1),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              final data = _videoController.videoList[index];
              return Stack(
                children: [
                  VideoPlayerItem(
                    videoUrl: data.videoURL,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(left: 20),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      data.userName,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: white,
                                      ),
                                    ),
                                    Text(
                                      data.caption,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: white,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.music_note,
                                          size: 15,
                                          color: white,
                                        ),
                                        Text(
                                          data.songName,
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: size.height / 6),
                              width: 100,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ProfilePhoto(profilePhoto: data.profilePhoto),
                                  Column(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          _videoController.videoLikes(data.id);
                                        },
                                        icon: Icon(
                                          Icons.favorite,
                                          size: 40,
                                          color: data.likes.contains(authController.user.uid) ? buttonColor : white,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      Text(
                                        data.likes.length.toString(),
                                        style: TextStyle(
                                          // fontSize: 20,
                                          color: white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Get.to(() => CommentScreen(
                                            id: data.id,
                                          ),);

                                        },
                                        icon: Icon(
                                          Icons.comment,
                                          size: 40,
                                          color: white,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      Text(
                                        data.commentCount.toString(),
                                        style: TextStyle(
                                          // fontSize: 20,
                                          color: white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          print("pressed");
                                        },
                                        icon: Icon(
                                          Icons.reply,
                                          size: 40,
                                          color: white,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      Text(
                                        data.shareCount.toString(),
                                        style: TextStyle(
                                          // fontSize: 20,
                                          color: white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  CircleAnimation(
                                    child: buildMusicAlbum(
                                      data.profilePhoto,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        }
      ),
    );
  }

  Widget ProfilePhoto({required String profilePhoto}) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Stack(
        children: [
          Positioned(
            left: 5,
            child: Container(
              width: 50,
              height: 50,
              padding: EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image(
                  image: NetworkImage(profilePhoto),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildMusicAlbum(String profilePhoto) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(11),
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [borderColor, white],
              ),
              borderRadius: BorderRadius.circular(25),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image(
                image: NetworkImage(
                  profilePhoto,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
