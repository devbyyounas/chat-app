import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formkey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();

  var height, width;
  // String _email = '';
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.only(top: height * 0.3),
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Center(
                      child: Text(
                        "Receive an email to\nReset your password",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Container(
                        height: height * 0.06,
                        width: width * 0.8,
                        child: TextFormField(
                          controller: emailcontroller,
                          cursorColor: Colors.white,
                          textInputAction: TextInputAction.done,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelText: "Email",
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 15)),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!value.contains('@')) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                          // onChanged: (value) {
                          //   _email = value;
                          // },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    InkWell(
                      onTap: () async {
                        if (_formkey.currentState!.validate()) {
                          try {
                            await FirebaseAuth.instance.sendPasswordResetEmail(
                                email: emailcontroller.text.trim());

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "Password reset email sent. Please check your inbox."),
                              ),
                            );
                            await Future.delayed(const Duration(seconds: 3));
                            Navigator.pop(context);
                            // Navigator.pushReplacementNamed(context, '/login');
                          } on FirebaseAuthException catch (e) {
                            String errorMessage = " An error ocurred";
                            if (e.code == 'user-not-found') {
                              errorMessage = 'no user found with this email!';
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(errorMessage)));
                          }
                        }
                      },
                      child: Container(
                        height: height * 0.05,
                        width: width * 0.7,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: const Color.fromARGB(255, 1, 42, 77),
                        ),
                        child: const Center(
                            child: Text(
                          "Submit",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                      ),
                    )
                  ],
                ),
              ))),
    );
  }
}
