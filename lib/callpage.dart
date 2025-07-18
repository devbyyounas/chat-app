import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_project/model.dart';

class CallPage extends StatefulWidget {
  const CallPage({super.key});

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  var height, width;
  List<UserModel> allUsers = [];
  getAllUsers() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection("Users").get();
    for (var users in snapshot.docs) {
      UserModel model = UserModel.fromMap(users.data() as Map<String, dynamic>);
      setState(() {
        allUsers.add(model);
      });
    }
  }

  @override
  void initState() {
    getAllUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: const Icon(
          Icons.search,
          color: Colors.white,
        ),
        title: const Center(
            child: Text(
          "Calls",
          style: TextStyle(
            color: Colors.white,
          ),
        )),
        actions: const [CircleAvatar()],
      ),
      body: Stack(
        children: [
          Container(
            height: height,
            width: width,
            color: Colors.black,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: height * 0.75,
              width: width,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: ListView.builder(
                    itemCount: allUsers.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          radius: 20,
                        ),
                        title: Text(allUsers[index].name!),
                        subtitle: Text(allUsers[index].email!),
                      );
                    }),
              ),
            ),
          )
        ],
      ),
    );
  }
}
