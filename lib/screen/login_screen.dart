import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supra/api/auth/login/login_bloc.dart';
import 'package:supra/colors.dart';
import 'package:supra/extensions.dart';
import 'package:supra/helpers.dart';
import 'package:supra/screen/sign_up_screen.dart';
import 'package:supra/widget/custom_btn.dart';
import 'package:supra/widget/logo_box.dart';

import '../widget/custom_text_field.dart';
import 'note_list_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fingerPrintController = TextEditingController();
  bool rememberPass = false;
  late LoginBloc loginBloc;

  @override
  void initState() {
    super.initState();
    loginBloc = LoginBloc();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        unFocus(context);
      },
      child: Scaffold(
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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.15),
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
                  40.height,
                  CustomTextField(
                    label: 'email',
                    controller: emailController,
                    prefixIcon: Icons.email,
                  ),
                  25.height,
                  CustomTextField(
                    isPassword: true,
                    label: 'password',
                    controller: passwordController,
                    prefixIcon: Icons.lock,
                  ),
                  25.height,
                  // CustomTextField(
                  //   // isPassword: true,
                  //   label: 'fingerprint text',
                  //   controller: fingerPrintController,
                  //   prefixIcon: Icons.fingerprint,
                  // ),
                  // 25.height,
                  // const Align(
                  //     alignment: Alignment.centerRight,
                  //     child: Text(
                  //       'forgot password?',
                  //       style: TextStyle(color: Colors.deepPurple, fontSize: 15, fontWeight: FontWeight.bold),
                  //     )),
                  // 20.height,
                  BlocConsumer(
                    bloc: loginBloc,
                    listener: (context, state) {
                      if (state is LoginSuccessState) {
                        push(context, NoteListScreen());
                        print("Loading...");
                      }
                      if (state is LoginErrorState) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
                      }
                    },
                    builder: (context, state) {
                      if (state is LoginLoadingState) {
                        print("Loading..s.");

                        return CircularProgressIndicator();
                      } else {
                        return customBtn('Sign in', () {
                          loginBloc.add(LoginEvent(
                              email: emailController.text,
                              fingerprint: 'ifxzidudzt',
                             password: passwordController.text
                          ));
                        });
                      }
                    },
                  ),
                  10.height,
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Remember Password?',
                          style: TextStyle(color: Colors.deepPurple),
                        ),
                        Checkbox(
                          value: rememberPass,
                          onChanged: (bool? value) {
                            setState(() {
                              rememberPass = value ?? false;
                            });
                          },
                          activeColor: primaryColor,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  Column(
                    children: [
                      Text(
                        'Or sign in With',
                        style: TextStyle(
                          color: Colors.deepPurple,
                        ),
                      ),
                      25.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          logoBox('devicon_google'),
                          10.width,
                          logoBox('logos_facebook'),
                          10.width,
                          logoBox('pajamas_twitter'),
                          10.width,
                          logoBox('logos_linkedin-icon'),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have  account ?',
                        style: TextStyle(
                          color: Colors.deepPurple,
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUpScreen(),
                                ));
                          },
                          child: Text(
                            'Sign up',
                            style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
                          ))
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
