import 'package:flutter/material.dart';
import 'package:tik_tok_clone/views/screens/auth/signup_screen.dart';
import 'package:get/get.dart';
import '../../../constants.dart';
import '../../widgets/text_input_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  var isLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => isLoading.value == true
            ? Scaffold(
                body: Center(
                child: CircularProgressIndicator(),
              ))
            : Scaffold(
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
                          "Login",
                          style: Theme.of(context).textTheme.headline2,
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
                              authController.loginUser(
                                email: _emailController.text,
                                password: _passwordController.text,
                              );
                              print("logged in successfully");
                            },
                            child: Center(
                              child: Text(
                                'Login',
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
                              'Don\'t have an account? ',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(SignUpScreen());
                              },
                              child: Text(
                                'Register',
                                style:
                                    TextStyle(fontSize: 20, color: buttonColor),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
