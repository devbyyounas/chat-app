import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_project/all_requests.dart';
import 'package:my_project/friends_model.dart';
import 'package:my_project/model.dart';
import 'package:my_project/sendreq_model.dart';
import 'package:my_project/staticdata.dart';
import 'package:uuid/uuid.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/Dashboard';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<FriendModel> allFriend = [];
  getAllFriend() async {
    allFriend.clear();
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("Friends")
        .where("userID", isEqualTo: StaticData.userModel!.userID)
        .get();
    for (var user in snapshot.docs) {
      FriendModel model =
          FriendModel.fromMap(user.data() as Map<String, dynamic>);
      setState(() {
        allFriend.add(model);
      });
    }
  }

  @override
  void initState() {
    getAllFriend();
    super.initState();
  }

  var height, width;
  int index = 0;
  PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: const Icon(
          Icons.search,
        ),
        title: Center(
          child: Text(
            "${StaticData.userModel!.name}",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        actions: [
          InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AllRequestPage()));
              },
              child: const CircleAvatar(
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ))
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: height,
              width: width,
              color: Colors.black,
              child: Column(
                children: [
                  Container(
                    height: height * 0.2,
                    width: width,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Column(
                            children: [
                              Container(
                                height: height * 0.15,
                                width: width * 0.15,
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  shape: BoxShape.circle,
                                  border: Border.all(),
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            top: 70, left: 15),
                                        child: Container(
                                          height: 15,
                                          width: 15,
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(Icons.add),
                                        )),
                                  ],
                                ),
                              ),
                              const Text(
                                "My Status",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                          Column(
                            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: height * 0.15,
                                width: width * 0.15,
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    color: Colors.blueGrey,
                                    shape: BoxShape.circle),
                              ),
                              Container(
                                height: height * 0.02,
                                width: width * 0.07,
                                child: const Text(
                                  "Amaeee",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                height: height * 0.15,
                                width: width * 0.15,
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    color: Colors.blue,
                                    shape: BoxShape.circle),
                              ),
                              Container(
                                height: height * 0.02,
                                width: width * 0.07,
                                child: const Text(
                                  "Aali",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                height: height * 0.15,
                                width: width * 0.15,
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    color: Colors.pink,
                                    shape: BoxShape.circle),
                              ),
                              Container(
                                height: height * 0.02,
                                width: width * 0.07,
                                child: const Text(
                                  "Adil",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                height: height * 0.15,
                                width: width * 0.15,
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    color: Colors.blue,
                                    shape: BoxShape.circle),
                              ),
                              Container(
                                height: height * 0.02,
                                width: width * 0.07,
                                child: const Text(
                                  "Ali",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                height: height * 0.15,
                                width: width * 0.15,
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    color: Colors.white,
                                    shape: BoxShape.circle),
                              ),
                              Container(
                                height: height * 0.02,
                                width: width * 0.07,
                                child: const Text(
                                  "Amjad",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                height: height * 0.15,
                                width: width * 0.15,
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    color: Colors.grey,
                                    shape: BoxShape.circle),
                              ),
                              Container(
                                height: height * 0.02,
                                width: width * 0.07,
                                child: const Text(
                                  "Ahmad",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                height: height * 0.15,
                                width: width * 0.15,
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    color: Colors.yellow,
                                    shape: BoxShape.circle),
                              ),
                              Container(
                                height: height * 0.02,
                                width: width * 0.07,
                                child: const Text(
                                  "Younas",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                height: height * 0.15,
                                width: width * 0.15,
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    color: Colors.red,
                                    shape: BoxShape.circle),
                              ),
                              Container(
                                height: height * 0.02,
                                width: width * 0.07,
                                child: const Text(
                                  "Naeem",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: height * 0.6,
                width: width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: allFriend.isEmpty
                      ? const Center(
                          child: Text(
                          "No friend Found!",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ))
                      : ListView.builder(
                          itemCount: allFriend.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: const CircleAvatar(
                                radius: 30,
                              ),
                              title: Text(allFriend[index].recieverName ?? ''),
                              // subtitle: Text(allFriend[index].email!),
                              // trailing: ElevatedButton(
                              //     onPressed: () async {
                              //       Uuid uid = Uuid();
                              //       String uniqueId = uid.v4();
                              //       SendRequest sendRequest = SendRequest(
                              //         receiverId: allUsers[index].userID,
                              //         receiverName: allUsers[index].name,
                              //         senderName: StaticData.userModel!.name,
                              //         senderId: StaticData.userModel!.userID,
                              //         uniqueId: uniqueId,
                              //       );
                              //       await FirebaseFirestore.instance
                              //           .collection("request")
                              //           .doc(uniqueId)
                              //           .set(sendRequest.toMap());
                              //       ScaffoldMessenger.of(context).showSnackBar(
                              //           SnackBar(content: Text("Request send!!")));
                              //     },
                              //     child: const Text("Req send")),
                            );
                          }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
