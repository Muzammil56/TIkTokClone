import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tik_tok_clone/constants.dart';
import 'package:tik_tok_clone/views/screens/home_screen.dart';
import '../models/user.dart' as model;
import '../views/screens/auth/login_screen.dart';

class AuthController extends GetxController {
  //instance of auth controller for GetX
  static AuthController instance = Get.find();

  late Rx<User?> _user;
  User get user => _user.value!;


  void signOutUser() async{
   await firebaseAuth.signOut().then((value) => box.erase().then((value) => Get.offAll(LoginScreen()))
    );
  }

  @override
  onReady(){
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  void _setInitialScreen(User? user) {
    if(_user == null){
      Get.offAll(()=>LoginScreen());
    }else{
      Get.offAll(()=> HomeScreen());
    }
  }


  //image picker Function
  late Rx<File?> _pickedImage;

  File? get profilePic => _pickedImage.value;

  void pickImage()async{
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if(image !=null){
      Get.snackbar("Success", "Image selected Successfully");
    }
    _pickedImage = Rx<File?>(File(image!.path));
  }

  //Upload pic to storage
  Future<String> _uploadToStorage(File image) async {
    Reference ref = firebaseStorage
        .ref()
        .child("profilePics")
        .child(firebaseAuth.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadURL = await snap.ref.getDownloadURL();
    return downloadURL;
  }

  //Register User

  void RegisterUser(
      {required String username,
      required String email,
      required String password,
      File? image}) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        // register user
        UserCredential credential = await firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password);
        String picURL = await _uploadToStorage(image);
        model.User user = model.User(
          name: username,
          profilePhoto: picURL,
          email: email,
          uid: credential.user!.uid,
        );
        await fireStore
            .collection("users")
            .doc(credential.user!.uid)
            .set(user.toJason());
      } else {
        Get.snackbar("Error", "Please Enter All required Fields");
      }
    } catch (e) {
      Get.snackbar("Error", "${e.toString()}");
    }
  }

  void loginUser({required String email, required String password}) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        Get.snackbar(
          'Error Logging in',
          'Please enter all the fields',
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error Loggin gin',
        e.toString(),
      );
    }
  }
}
