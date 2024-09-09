import 'package:flutter/material.dart';
import 'package:supra/colors.dart';
import 'package:supra/extentions.dart';
import 'package:supra/helpers.dart';

import '../widget/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
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
        resizeToAvoidBottomInset: false,
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
                  Image.asset(
                    'assets/images/logo-no-background 1.png',
                    fit: BoxFit.cover,
                  ),
                  20.height,

                  const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Sign In',
                        style: TextStyle(color: Colors.deepPurple, fontSize: 30),
                      )),
                  20.height,

                  20.height,
                  customTextField(
                    label: 'Username',
                    controller: usernameController,
                    prefixIcon: Icons.person_add_alt_1_rounded,
                  ),
                  20.height,
                  customTextField(
                    label: 'password',
                    controller: passwordController,
                    prefixIcon: Icons.email,
                  ),

                  20.height,
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Sign In',
                        style: TextStyle(color: Colors.deepPurple, fontSize: 30,fontWeight: FontWeight.bold),
                      )),
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
                    child: Text("Sign in",style: TextStyle(color: Colors.white,fontSize: 15),),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                  Row(
                    children: [
                      Text('Don\'t have  account ?'),
                      GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ));
                          },
                          child: Text('Sign up',style: TextStyle(fontWeight: FontWeight.bold),))
                    ],
                  )

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
