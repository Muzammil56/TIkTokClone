import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tik_tok_clone/views/screens/add_post_screen.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tik_tok_clone/views/screens/search_screen.dart';
import 'package:tik_tok_clone/views/screens/video_screen.dart';
import 'controllers/auth_controller.dart';
import 'package:tik_tok_clone/views/screens/profile_screen.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           IconButton(
//             icon: Icon(Icons.logout),
//             onPressed: () => authController.signOutUser(),
//           ),
//         ],
//       ),
//     );
//   }
// }

final box = GetStorage();

// Page List
List pages = [
  VideoScreen(),
  SearchScreen(),
  AddVideoScreen(),
  Text("Messages"),
  ProfileScreen(uid: authController.user.uid),
];

// COLORS
const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;
const white = Colors.white;

// FireBase
var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var fireStore = FirebaseFirestore.instance;

// AUthControllers
var authController = AuthController.instance;

// Text Theme
TextTheme textTheme = TextTheme(
  headline1:
      TextStyle(color: buttonColor, fontSize: 35, fontWeight: FontWeight.w900),
  headline2: TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.w700,
  ),
  button: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
  ),
);
