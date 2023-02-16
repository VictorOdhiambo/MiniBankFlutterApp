import 'dart:convert';

import 'package:bank_app/signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:bank_app/user.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  User user = User();
  // MAY HAVE TO CHANGE THE IP IF TESTING ON REAL DEVICE
  Future save() async {
    var res =
        await http.post("http://192.168.43.152:6500/api/auth/create-account",
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(user.toJson()));

    if (res.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Account creation was successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);

      print(res.body);
      // open dashboard
      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => const SignIn()));
    } else {
      Fluttertoast.showToast(
          msg: res.body,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
                top: 0,
                child: SvgPicture.asset(
                  'images/top.svg',
                  width: 400,
                  height: 250,
                )),
            Container(
              alignment: Alignment.center,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 180,
                      width: 200,
                    ),
                    Text("Sign Up",
                        style: GoogleFonts.pacifico(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                            color: Colors.blue)),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller: TextEditingController(text: user.email),
                        onChanged: (value) {
                          user.name = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Full name is required";
                          }
                        },
                        decoration: InputDecoration(
                            hintText: "Enter full name...",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.red)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.blue)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.red))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller: TextEditingController(text: user.email),
                        onChanged: (value) {
                          user.email = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Email is required";
                          }
                        },
                        decoration: InputDecoration(
                            hintText: "Enter email...",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.red)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.blue)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.red))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller: TextEditingController(text: user.email),
                        onChanged: (value) {
                          user.idNumber = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "ID number is required";
                          }
                        },
                        decoration: InputDecoration(
                            hintText: "Enter ID No....",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.red)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.blue)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.red))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller: TextEditingController(text: user.email),
                        onChanged: (value) {
                          user.password = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password is required";
                          }
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: "Enter Password....",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.red)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.blue)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.red))),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Container(
                          height: 50,
                          width: 350,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(16.0),
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.blue,
                              textStyle: const TextStyle(fontSize: 20),
                            ),
                            onPressed: () => {
                              if (_formKey.currentState!.validate()) {save()}
                            },
                            child: Text("Sign Up",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.white)),
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
