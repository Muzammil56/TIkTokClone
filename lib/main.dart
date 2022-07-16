import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tik_tok_clone/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tik_tok_clone/controllers/auth_controller.dart';
import 'package:tik_tok_clone/views/screens/auth/login_screen.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tik_tok_clone/views/screens/home_screen.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value){
    Get.put(AuthController());
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "TikTok Clone",
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
        textTheme: textTheme
      ),
      home: _navigatorFunction(context),
    );
  }

  _navigatorFunction(BuildContext context){
    if(box.read("email") != null){
      return HomeScreen();
    }else{
      return LoginScreen();
    }
  }
}
