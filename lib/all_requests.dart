import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_project/home.dart';
import 'package:my_project/login.dart';
import 'package:my_project/sendreq_model.dart';
import 'package:my_project/staticdata.dart';

class AllRequestPage extends StatefulWidget {
  const AllRequestPage({super.key});

  @override
  State<AllRequestPage> createState() => _AllRequestPageState();
}

class _AllRequestPageState extends State<AllRequestPage> {
  List<SendRequest> getAllRequest = [];
  void getAllRequests() async {
    getAllRequest.clear();
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("request")
        .where("receiverId", isEqualTo: StaticData.userModel!.userID)
        .get();
    for (var user in snapshot.docs) {
      SendRequest model =
          SendRequest.fromMap(user.data() as Map<String, dynamic>);
      setState(() {
        getAllRequest.add(model);
      });
    }
  }

  @override
  void initState() {
    getAllRequests();
    super.initState();
  }

  var height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                icon: Icon(Icons.arrow_back)),
            SizedBox(
              width: width * 0.085,
            ),
            Text("all Requests")
          ],
        )
      ],
    )));
  }
}
