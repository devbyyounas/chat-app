import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_project/login.dart';
import 'package:my_project/model.dart';
import 'package:uuid/uuid.dart';

class SignUpPage extends StatefulWidget {
  static const String routeName = '/register';
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _number = TextEditingController();
  final _confirmpassword = TextEditingController();
  bool _isPasswordValid = false;
  var height, width;

  // @override
  //   void dispose(){
  //     _name.dispose();
  // _email.dispose();
  // _number.dispose();
  // _password.dispose();
  // _confirmpassword.dispose();
  // super.dispose();
  //   }

  bool validatePassword(String password) {
    final hasMinLength = password.length >= 8;
    final hasAlphabet = password.contains(RegExp(r'[A-Za-z]'));
    final hasSpecial = password.contains(RegExp(r'[!@#\$&*~%^]'));
    return hasMinLength && hasAlphabet && hasSpecial;
  }

  void registerUser() async {
    _formKey.currentState!.save();
    final _isValid = _formKey.currentState!.validate();
    if (!_isValid) return;
    if (!validatePassword(_password.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Password is not formatted correctly")));
      return;
    }
    if (_password != _confirmpassword) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Password doesn't match")));
      return;
    }
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: _email.text, password: _password.text);
      String userId = userCredential.user!.uid;
      UserModel model = UserModel(
        email: _email.text,
        name: _name.text,
        password: _password.text,
        number: _number.text,
        userID: userId,
      );
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userId)
          .set(model.toMap());

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("You are registered successfully")));
      Future.delayed(Duration(microseconds: 400), (() {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      }));
    } on FirebaseAuthException catch (e) {
      String errorMessage = "Registration Failed!";
      if (e.code == 'email-already-in-use') {
        errorMessage = 'This email is already in use';
      } else if (e.code == 'invalid-email') {
        errorMessage = "Invalid Email!";
      } else if (e.code == 'weak-password') {
        errorMessage = "Password is too weak";
      } else {
        errorMessage = e.message ?? "Something went wrong";
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        "An error occured: ${e.toString()}",
      )));
    }
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.08),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height * 0.1,
                  ),
                  const Center(
                    child: Text(
                      "Register",
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
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
                    child: TextFormField(
                      decoration: const InputDecoration(
                          labelText: "Name",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 10)),
                      validator: (value) => value!.isEmpty
                          ? 'Fill all the required fields'
                          : null,
                      controller: _name,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          labelText: "number",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 10)),
                      validator: (value) => value!.isEmpty
                          ? 'Fill all the required fields'
                          : null,
                      controller: _number,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          labelText: "Email",
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          border: InputBorder.none),
                      validator: (value) {
                        if (value!.isEmpty)
                          return 'Fill all the required fields';
                        if (!value.contains('@')) return 'Invalid email format';
                        return null;
                      },
                      controller: _email,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextFormField(
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                            labelText: "Password",
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            border: InputBorder.none,
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
                        validator: (value) => value!.isEmpty
                            ? 'Fill all the required fields'
                            : null,
                        onChanged: (value) {
                          _password.text = value;
                          setState(() {
                            _isPasswordValid = validatePassword(value);
                          });
                        }),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Row(
                    children: [
                      Icon(
                        _isPasswordValid ? Icons.check_circle : Icons.cancel,
                        color: _isPasswordValid ? Colors.green : Colors.red,
                        size: 20,
                      ),
                      SizedBox(
                        width: width * 0.01,
                      ),
                      const Expanded(
                          child: Text(
                        "Password must be of minimum eight charchter long with alphabet and special character",
                        style: TextStyle(fontSize: 12),
                      ))
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextFormField(
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                          labelText: "confirm-Password",
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          border: InputBorder.none,
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
                      validator: (value) =>
                          value!.isEmpty ? 'Fill the require field' : null,
                      controller: _confirmpassword,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  ElevatedButton(
                      onPressed: registerUser,
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(width * 0.7, height * 0.06),
                          backgroundColor: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          )),
                      child: const Text(
                        "Register",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )),
                  SizedBox(
                    height: height * 0.15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
