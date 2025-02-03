import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // Dispose the controller when no longer needed
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
                  SizedBox(height: 90),
                  Text(
                    "Hello,",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Welcome Back!",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 60),
                  Text(
                    "Email",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 10),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
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
                              borderSide: BorderSide(
                                  color: Color(0xffd9d9d9), width: 1.5),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xffd9d9d9), width: 1.5),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return "Please Enter your Email Address";
                            } else if (!RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-\=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value.toString())) {
                              return "Please enter a valid email address";
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                        SizedBox(height: 30),
                        Text(
                          "Password",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          // todo - flutter pw validator
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
                              borderSide: BorderSide(
                                  color: Color(0xffd9d9d9), width: 1.5),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xffd9d9d9), width: 1.5),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),

                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            // RegExp regexpPattern = RegExp(
                            //     r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                            if (value.toString().isEmpty) {
                              return "Please enter your password";
                            } else if (value.toString().length < 8) {
                              return "Password must be greater than 8";
                              // } else if (!regexpPattern
                              //     .hasMatch(value.toString())) {
                              //   return "Please enter a valid Password";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffff9c00),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff129575),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onPressed: () {
                        String email = _emailController.text;
                        String password = _passwordController.text;
                        if (_formKey.currentState!.validate()) {
                          userPovider
                              .signIn(
                            email: email,
                            password: password,
                          )
                              .then((value) async {
                            print("value of sign in screen $value");
                            if (value['isPassed']) {
                              Navigator.pushReplacementNamed(context, "/main");
                            } else {
                              print("message ${value["message"]}");
                            }
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Please Enter valid data!"),
                            ),
                          );
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Sign In",
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
                  SizedBox(height: 20),
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
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/signup");
                        },
                        child: Text(
                          "Sign up",
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
