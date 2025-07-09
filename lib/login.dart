import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_project/auth.dart';
import 'package:my_project/forgot_password.dart';
import 'package:my_project/model.dart';
import 'package:my_project/sign_up.dart';
import 'package:my_project/staticdata.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  final GoogleSignIn googleSignIn = GoogleSignIn();
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount == null) {
        return;
      }
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;
    } catch (e) {
      print(e.toString());
    }
  }

  final _email = TextEditingController();
  final _password = TextEditingController();
  var height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.2,
                ),
                const Center(
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
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
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: "Email",
                        //hintText: "Email",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter you email";
                        }
                        if (!value.contains("@")) {
                          return "Please enter a valid email";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _email.text = value;
                      },
                    ),
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
                      obscureText: _obscureText,
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                          labelText: "Password",
                          //hintText: "Password",
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ))),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your password";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _password.text = value;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.001,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgotPassword()));
                          },
                          child: const Text(
                            "Forget your password?",
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          )),
                    )
                  ],
                ),
                SizedBox(
                  height: height * 0.001,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      QuerySnapshot snapshot = await FirebaseFirestore.instance
                          .collection("users")
                          .where("email", isEqualTo: _email.text)
                          .where("password", isEqualTo: _password.text)
                          .get();
                      if (snapshot.docs.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Email or Password is incorrect!")));
                      } else {
                        UserModel model = UserModel.fromMap(
                            snapshot.docs[0].data() as Map<String, dynamic>);
                        print(model);
                        StaticData.userModel = model;
                      }
                      // try {
                      //   UserCredential? userCredential = await _auth
                      //       .signInWithEmailAndPassword(_email.text, _password.text);
                      //   if (userCredential != null) {
                      //     Navigator.pushReplacementNamed(context, '/home');
                      //   } else {
                      //     ScaffoldMessenger.of(context).showSnackBar(
                      //         const SnackBar(
                      //             content: Text(
                      //                 "Invalid Credentials! Please try Again")));
                      //   }
                      // } on FirebaseAuthException catch (e) {
                      //   String message = "Login Failed";
                      //   if (e.code == 'user-not-found') {
                      //     message = 'No user found for that email';
                      //   } else if (e.code == 'wrong-password') {
                      //     message = "Wrong Password!";
                      //   } else {
                      //     message = e.message ?? 'Something went wrong';
                      //   }
                      //   ScaffoldMessenger.of(context)
                      //       .showSnackBar(SnackBar(content: Text(message)));
                      // }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(width * 0.6, height * 0.05),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      )),
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: height * 0.001,
                      width: width * 0.15,
                      color: Colors.black,
                    ),
                    const Text(
                      "OR",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: height * 0.001,
                      width: width * 0.15,
                      color: Colors.black,
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.06,
                ),
                const Text(
                  "Sign in with:",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                InkWell(
                  onTap: () async {
                    await signInWithGoogle();
                  },
                  child: Container(
                    height: height * 0.05,
                    width: width * 0.5,
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(30)),
                    child: const Center(
                      child: Text(
                        "Login with Google",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.09,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpPage()));
                        },
                        child: const Text("Register"))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
