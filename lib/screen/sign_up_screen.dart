import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      body: Consumer<UserProvider>(
        builder: (context, userPovider, child) {
          return Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40),
                  Text(
                    "Create an account",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Let's help you set up your account,\nit won't take long.",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 25),
                  Text(
                    "Name",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Enter Name",
                      hintStyle: TextStyle(
                        color: Color(0xffd9d9d9),
                      ),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xffd9d9d9), width: 1.5),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xffd9d9d9), width: 1.5),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onSubmitted: (val) {},
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Email",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Enter Email",
                      hintStyle: TextStyle(
                        color: Color(0xffd9d9d9),
                      ),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xffd9d9d9), width: 1.5),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xffd9d9d9), width: 1.5),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onSubmitted: (val) {},
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Password",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Enter Password",
                      hintStyle: TextStyle(
                        color: Color(0xffd9d9d9),
                      ),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xffd9d9d9), width: 1.5),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xffd9d9d9), width: 1.5),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onSubmitted: (val) {},
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Confirm Password",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Retype Password",
                      hintStyle: TextStyle(
                        color: Color(0xffd9d9d9),
                      ),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xffd9d9d9), width: 1.5),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xffd9d9d9), width: 1.5),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onSubmitted: (val) {},
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Accept Terms & Condition",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffff9c00),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff129575),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onPressed: () {
                        userPovider
                            .signUp(
                          email: "eyael_abd@gmail.com",
                          password: "p@ss_word",
                          name: "eyael",
                        )
                            .then((value) async {
                          print("value of sign in screen $value");
                          if (value['isPassed']) {
                            // Navigator.pushReplacementNamed(context, "/main");
                            print("message  isPassed true ${value["message"]}");
                          } else {
                            print("message ${value["message"]}");
                          }
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 20),
                          Icon(
                            IconsaxPlusLinear.arrow_right,
                            size: 20,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 50,
                        child: Divider(
                          height: 1,
                          color: Color(0xffd9d9d9),
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Or Sign In With",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xffd9d9d9),
                        ),
                      ),
                      SizedBox(width: 5),
                      SizedBox(
                        width: 50,
                        child: Divider(
                          height: 1,
                          color: Color(0xffd9d9d9),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.asset("assets/icons/google.png"),
                      ),
                      SizedBox(width: 15),
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.asset("assets/icons/facebook.png"),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already a member?",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/signin");
                        },
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xffff9c00),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
