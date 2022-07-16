import 'package:flutter/material.dart';
import 'package:tik_tok_clone/constants.dart';
import 'package:tik_tok_clone/views/widgets/text_input_field.dart';
import 'package:tik_tok_clone/controllers/auth_controller.dart';
import 'package:get/get.dart';

import 'login_screen.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "TikTok Clone",
                  style: Theme.of(context).textTheme.headline1,
                ),
                Text(
                  "Register",
                  style: Theme.of(context).textTheme.headline2,
                ),
                SizedBox(
                  height: 25,
                ),
                Stack(
                  children: [
                    const CircleAvatar(
                      radius: 64,
                      backgroundImage:
                          AssetImage("assets/images/person_placeholder.png"),
                      backgroundColor: backgroundColor,
                    ),
                    Positioned(
                      bottom: -10,
                      left: 80,
                      child: IconButton(
                        icon: Icon(Icons.add_a_photo),
                        onPressed: () {
                          print("Pick an image");
                          authController.pickImage();
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextInputField(
                    controller: _usernameController,
                    icon: Icons.person,
                    labelText: "User Name",
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextInputField(
                    controller: _emailController,
                    icon: Icons.email,
                    labelText: "Email",
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextInputField(
                    controller: _passwordController,
                    icon: Icons.lock,
                    labelText: "Password",
                    isObscure: true,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 50,
                  decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      print("register user");
                      authController.RegisterUser(
                        username: _usernameController.text,
                        email: _emailController.text,
                        password: _passwordController.text,
                        image: authController.profilePic,
                      );
                    },
                    child: Center(
                      child: Text(
                        'Register',
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account? ',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Get.to(()=> LoginScreen());
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 20, color: buttonColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
