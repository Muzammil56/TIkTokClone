import 'dart:io';
import 'package:tik_tok_clone/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tik_tok_clone/controllers/auth_controller.dart';
import 'package:tik_tok_clone/views/screens/auth/confirm_screen.dart';

class AddVideoScreen extends StatelessWidget {
   AddVideoScreen({Key? key}) : super(key: key);

  AuthController _authController = AuthController();

  // Future<void> showOptionsDialog(BuildContext context) {
  //   return showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           // title: Text("Options"),
  //           content: SingleChildScrollView(
  //             child: ListBody(
  //               children: [
  //                 GestureDetector(
  //                   child: Text("Capture Image From Camera"),
  //                   onTap: () {
  //                     // openCamera();
  //                   },
  //                 ),
  //                 Padding(padding: EdgeInsets.all(10)),
  //                 GestureDetector(
  //                   child: Text("Take Image From Gallery"),
  //                   onTap: () {
  //                     // openGallery();
  //                   },
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       }
  //   );
  // }
  // _showBottomSheet(BuildContext context) {
  //   showModalBottomSheet<void>(context: context, builder: (BuildContext context) {
  //     return Container(
  //       child: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: <Widget>[
  //           Container(
  //             child: ListTile(
  //               title: Text("Gallery"),
  //               leading: Icon(Icons.image),
  //             ),
  //           ),
  //           Container(
  //             child: ListTile(
  //               title: Text("Camera"),
  //               leading: Icon(Icons.camera),
  //             ),
  //           ),
  //         ],
  //       ),
  //     );
  //   }
  //   );
  // }

  _pickVideo(ImageSource src, BuildContext context) async{
    print("video waly functiin mai agya hy");
    final video = await ImagePicker().pickVideo(source: src);
    print(video.toString());
    if(video != null){
      print("video milgai hy");
      Get.to(()=> ConfirmScreen(
        video: File(video.path),
        videoPath: video.path,
      ));
    }
  }

  _showBottomSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        // height: 250,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: borderColor.shade900,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              child: ListTile(
                title: Text("Gallery"),
                leading: Icon(Icons.image),
                onTap: () => _pickVideo(ImageSource.gallery, context),
              ),
            ),
            Container(
              child: ListTile(
                title: Text("Camera"),
                leading: Icon(Icons.camera),
                onTap: () => _pickVideo(ImageSource.camera, context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
            onPressed: () => _authController.signOutUser(),
          ),
        ],
      ),
      body: Center(
        child: InkWell(
          onTap: () => _showBottomSheet(context),
          child: Container(
            height: 50,
            width: 190,
            color: buttonColor,
            child: Center(
              child: Text(
                "Add Video",
                style: TextStyle(
                  color: backgroundColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
