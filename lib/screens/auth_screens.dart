import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_fire/providers/theme_provider.dart';
import 'package:todo_fire/services/firestore_service.dart';
import 'package:todo_fire/widgets/custom_container.dart';
import 'package:todo_fire/widgets/custom_form.dart';
import 'package:todo_fire/widgets/custom_input.dart';
import 'package:todo_fire/widgets/snack_bar.dart';

class AuthScreens extends StatefulWidget {
  const AuthScreens({super.key});

  @override
  State<AuthScreens> createState() => _AuthScreensState();
}

class _AuthScreensState extends State<AuthScreens> {
  final authService = AuthService();

  // Controllers for all the text form fields
  final TextEditingController username = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  // login form widget tree
  Widget loginPageForm() => CustomForm(
        started: loginAnimation,
        children: [
          CustomInput(
            label: "User Name",
            controller: username,
            keyboardType: TextInputType.emailAddress,
            obscure: false,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomInput(
            label: "Password",
            controller: password,
            obscure: true,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    reset = true;
                    login = false;
                    signIn = false;
                    setState(() {
                      resetAnimation = true;
                    });
                    Timer(const Duration(milliseconds: 200), () {
                      setState(() {
                        resetAnimation = updateState(true);
                      });
                    });
                  });
                },
                child: const Text(
                  "forgot password?",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: MediaQuery.sizeOf(context).width - 50,
            height: 50,
            child: ElevatedButton(
              onPressed: () async {
                if (username.text.isNotEmpty && password.text.isNotEmpty) {
                  User? user = await authService.signInWithEmail(
                      username.text.trim(), password.text.trim());
                  if (user != null) {
                    Navigator.pushReplacementNamed(context, "Home");
                  } else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const CustomSnack() as SnackBar);
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
              ),
              child: const Text(
                "Log in",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have an account? "),
              TextButton(
                onPressed: () {
                  setState(() {
                    reset = false;
                    login = false;
                    signIn = true;
                    setState(() {
                      signInAnimation = true;
                    });
                    Timer(const Duration(milliseconds: 5), () {
                      setState(() {
                        signInAnimation = updateState(true);
                      });
                    });
                  });
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsetsDirectional.zero,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  splashFactory: null,
                ),
                child: const Text(
                  "Sign Up",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          )
        ],
      );

  // sign up form widget tree
  Widget signUpForm() {
    return CustomForm(
      started: signInAnimation,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomInput(
              label: "User Name",
              controller: username,
              obscure: false,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomInput(
              label: "Email",
              controller: email,
              keyboardType: TextInputType.emailAddress,
              obscure: false,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomInput(
              label: "Password",
              controller: password,
              obscure: true,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomInput(
              label: "Confirm Password",
              controller: confirmPassword,
              obscure: true,
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width - 50,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (email.text.isNotEmpty &&
                      password.text.isNotEmpty &&
                      password.text == confirmPassword.text) {
                    authService.signUpWithEmail(
                      username.text.trim(),
                      email.text.trim(),
                      password.text.trim(),
                    );
                    setState(() {
                      reset = false;
                      signIn = false;
                      login = true;
                    });
                    // Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const CustomSnack() as SnackBar);
                  }
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  // backgroundColor: myColors.black,
                  // foregroundColor: myColors.white,
                ),
                child: const Text("Sign Up"),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Do you have an account? "),
                TextButton(
                  onPressed: () {
                    setState(() {
                      reset = false;
                      login = true;
                      signIn = false;
                      setState(() {
                        loginAnimation = true;
                      });
                      Timer(const Duration(milliseconds: 5), () {
                        setState(() {
                          loginAnimation = updateState(true);
                        });
                      });
                    });
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsetsDirectional.zero,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    shadowColor: Colors.transparent,
                    splashFactory: null,
                    // foregroundColor: myColors.white,
                  ),
                  child: const Text(
                    "Log in",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      // color: myColors.black,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            )
          ],
        )
      ],
    );
  }

  // reset password form widget tree
  Widget resetForm() => AnimatedContainer(
        width: MediaQuery.sizeOf(context).width - 20,
        height: resetAnimation
            ? MediaQuery.sizeOf(context).height * 6 / 8
            : MediaQuery.sizeOf(context).height / 3,
        duration: const Duration(seconds: 1),
        curve: Curves.decelerate,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Enter email to receive reset message",
              style: TextStyle(
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomInput(
              label: "Email",
              controller: email,
              keyboardType: TextInputType.emailAddress,
              obscure: false,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      reset = false;
                      login = true;
                      signIn = false;
                      setState(() {
                        loginAnimation = true;
                        resetAnimation = true;
                        signInAnimation = true;
                      });
                      Timer(const Duration(milliseconds: 1000), () {
                        setState(() {
                          loginAnimation = updateState(true);
                        });
                      });
                    });
                  },
                  child: const Text(
                    "Back to Login?",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width - 100,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  authService.resetPass(email.text.trim(), context);
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  // backgroundColor: myColors.black,
                  // foregroundColor: myColors.white,
                ),
                child: const Text("Reset Password"),
              ),
            ),
          ],
        ),
      );

  // Animation booleans
  bool loginAnimation = false;
  bool signInAnimation = false;
  bool resetAnimation = false;

  // Screen booleans
  bool login = false;
  bool signIn = false;
  bool reset = false;

  bool updateState(bool state) {
    setState(() {
      state = !state;
    });
    return state;
  }

  @override
  void dispose() {
    username.dispose();
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    login = true;
    signIn = false;
    reset = false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(const Duration(seconds: 5), () {});
      loginAnimation = true;
      resetAnimation = true;
      signInAnimation = true;
      setState(() {
        loginAnimation = updateState(true);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // This is the upper section
            if (login == true && reset == false && signIn == false)
              CustomContainer(
                // Login App Bar
                page: login,
                pageAnimation: loginAnimation,
                title: "Log In",
                alignment: AlignmentDirectional.bottomCenter,
                border: const BorderRadius.only(
                  bottomRight: Radius.circular(50),
                  bottomLeft: Radius.circular(50),
                ),
              )
            else if (login == false && reset == false && signIn == true)
              signUpForm() // Sign Up Form
            else if (login == false && reset == true && signIn == false)
              CustomContainer(
                // Reset top App Bar
                page: reset,
                pageAnimation: resetAnimation,
                title: "Reset Password",
                alignment: AlignmentDirectional.bottomCenter,
                border: const BorderRadius.only(
                  bottomRight: Radius.circular(50),
                  bottomLeft: Radius.circular(50),
                ),
              ),

            // Middle section for the Reset Form only

            if (reset == true && signIn == false) resetForm(),

            // This is the bottom section
            if (reset == false && signIn == false)
              loginPageForm() // Log In Form
            else if (reset == false && signIn == true)
              CustomContainer(
                // Sign Up App Bar
                page: signIn,
                pageAnimation: signInAnimation,
                title: "Sign Up",
                alignment: AlignmentDirectional.topCenter,
                border: const BorderRadius.only(
                  topRight: Radius.circular(50),
                  topLeft: Radius.circular(50),
                ),
              )
            else
              CustomContainer(
                // Reset empty bottom App Bar
                page: reset,
                pageAnimation: resetAnimation,
                title: "",
                alignment: AlignmentDirectional.topCenter,
                border: const BorderRadius.only(
                  topRight: Radius.circular(50),
                  topLeft: Radius.circular(50),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: IconButton(
        onPressed: () {
          setState(() {
            themeProvider.toggleTheme();
            updateState(login);
            updateState(signIn);
            updateState(reset);
          });
        },
        icon: Icon(
          Icons.brightness_6,
          color: !themeProvider.isDark ? Colors.black : Colors.white,
        ),
      ),
    );
  }
}
