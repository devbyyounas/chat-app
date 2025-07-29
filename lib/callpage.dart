import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_project/model.dart';
import 'package:my_project/sendreq_model.dart';
import 'package:my_project/staticdata.dart';
import 'package:uuid/uuid.dart';

class CallPage extends StatefulWidget {
  const CallPage({super.key});

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  var height, width;
  List<UserModel> allUsers = [];
  getAllUsers() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("Users")
        .where("userID", isNotEqualTo: StaticData.userModel!.userID)
        .get();
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
              height: height * 0.8,
              width: width,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: ListView.builder(
                    itemCount: allUsers.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          radius: 20,
                        ),
                        title: Text(allUsers[index].name!),
                        subtitle: Text(allUsers[index].email!),
                        trailing: ElevatedButton(
                            onPressed: () async {
                              Uuid uid = Uuid();
                              String uniqId = uid.v4();
                              SendRequest reqsend = SendRequest(
                                receiverName: allUsers[index].name,
                                receiverId: allUsers[index].userID,
                                senderName: StaticData.userModel!.name,
                                senderId: StaticData.userModel!.userID,
                                uniqueId: uniqId,
                              );
                              await FirebaseFirestore.instance
                                  .collection("request")
                                  .doc(uniqId)
                                  .set(reqsend.toMap());

                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text("Request Send Successfully!")));
                            },
                            child: Text("Send req")),
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
