import 'package:flutter/material.dart';
import 'package:supra/colors.dart';
import 'package:supra/extentions.dart';
import 'package:supra/helpers.dart';
import 'package:supra/screen/login_screen.dart';

import '../widget/custom_text_field.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.25),
                  const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.deepPurple, fontSize: 30),
                      )),
                  20.height,
                  customTextField(
                    label: 'Name',
                    controller: nameController,
                    prefixIcon: Icons.person,
                  ),
                  20.height,
                  customTextField(
                    label: 'Username',
                    controller: usernameController,
                    prefixIcon: Icons.person_add_alt_1_rounded,
                  ),
                  20.height,
                  customTextField(
                    label: 'Email',
                    controller: emailController,
                    prefixIcon: Icons.email,
                  ),
                  20.height,
                  customTextField(
                    label: 'Location',
                    controller: locationController,
                    prefixIcon: Icons.location_on,
                  ),
                  20.height,
                  customTextField(
                    label: 'Password',
                    controller: passwordController,
                    prefixIcon: Icons.lock,
                  ),
                  20.height,
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      minimumSize: Size(double.infinity, 50),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                  Row(
                    children: [
                      Text('Already have an account ?'),
                      GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ));
                          },
                          child: Text('Sign in',style: TextStyle(fontWeight: FontWeight.bold),))
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
                  onTap: () {},
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
    );
  }
}
