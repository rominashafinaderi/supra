import 'package:flutter/material.dart';
import 'package:supra/extensions.dart';
import 'package:supra/helpers.dart';
import 'package:supra/screen/login_screen.dart';
import 'package:supra/widget/custom_btn.dart';

import '../widget/custom_text_field.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        pushAndRemoveUntil(context, LoginScreen(), (route) => false);
        return true;
      },
      child: GestureDetector(
        onTap: () {
          unFocus(context);
        },
        child: Scaffold(
          //resizeToAvoidBottomInset: false,
          body: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/background/signUpBak.png',
                fit: BoxFit.cover,
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                    const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.deepPurple, fontSize: 30),
                        )),
                    40.height,
                    CustomTextField(
                      label: 'Name',
                      controller: nameController,
                      prefixIcon: Icons.person,
                    ),
                    20.height,
                    CustomTextField(
                      label: 'Username',
                      controller: usernameController,
                      prefixIcon: Icons.person_add_alt_1_rounded,
                    ),
                    20.height,
                    CustomTextField(
                      label: 'Email',
                      controller: emailController,
                      prefixIcon: Icons.email,
                    ),
                    20.height,
                    CustomTextField(
                      label: 'Location',
                      controller: locationController,
                      prefixIcon: Icons.location_on,
                    ),
                    20.height,
                    CustomTextField(
                      label: 'Password',
                      controller: passwordController,
                      isPassword: true,
                      prefixIcon: Icons.lock,
                    ),
                    35.height,
                    customBtn('Sign Up', () {}),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account ?',
                          style: TextStyle(
                            color: Colors.deepPurple,
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              pushAndRemoveUntil(context, LoginScreen(), (route) => false);
                            },
                            child: Text(
                              'Sign in',
                              style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
                            ))
                      ],
                    )
                  ],
                ),
              ),
              Positioned(
                top: 50,
                left: 10,
                child: Material(
                  shadowColor: Colors.transparent,
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                  child: InkWell(
                    onTap: () {
                      pushAndRemoveUntil(context, LoginScreen(), (route) => false);
                    },
                    splashColor: Colors.transparent,
                    borderRadius: BorderRadius.circular(15),
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Colors.deepPurple,
                          size: 18,
                        ),
                        Text('back', style: TextStyle(color: Colors.deepPurple)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
