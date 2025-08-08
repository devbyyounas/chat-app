import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_project/dashboard.dart';
import 'package:my_project/friends_model.dart';
import 'package:my_project/home.dart';
import 'package:my_project/login.dart';
import 'package:my_project/sendreq_model.dart';
import 'package:my_project/staticdata.dart';
import 'package:uuid/uuid.dart';

class AllRequestPage extends StatefulWidget {
  const AllRequestPage({super.key});

  @override
  State<AllRequestPage> createState() => _AllRequestPageState();
}

class _AllRequestPageState extends State<AllRequestPage> {
  List<SendRequest> allRequest = [];
  void getAllRequests() async {
    allRequest.clear();
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("request")
        .where("receiverId", isEqualTo: StaticData.userModel!.userID)
        .get();
    for (var user in snapshot.docs) {
      SendRequest model =
          SendRequest.fromMap(user.data() as Map<String, dynamic>);
      setState(() {
        allRequest.add(model);
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
                      MaterialPageRoute(builder: (context) => Dashboard()));
                },
                icon: const Icon(Icons.arrow_back)),
            SizedBox(
              width: width * 0.085,
            ),
            const Text("all Requests"),
          ],
        ),
        allRequest.isEmpty
            ? const Text("No request found")
            : Expanded(
                child: ListView.builder(
                    itemCount: allRequest.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const CircleAvatar(
                          radius: 30,
                        ),
                        title: Text(allRequest[index].senderName!),
                        subtitle: const Text(""),
                        trailing: ElevatedButton(
                            onPressed: () async {
                              Uuid uid = Uuid();
                              String uidone = uid.v4();
                              FriendModel model1 = FriendModel(
                                  recieverId: allRequest[index].receiverId,
                                  recieverName: allRequest[index].receiverName,
                                  uniqId: uidone,
                                  userID: allRequest[index].senderId);
                              await FirebaseFirestore.instance
                                  .collection("Friends")
                                  .doc(uidone)
                                  .set(model1.toMap());

                              String uidtwo = uid.v4();
                              FriendModel modeltwo = FriendModel(
                                recieverId: allRequest[index].senderId,
                                recieverName: allRequest[index].senderName,
                                uniqId: uidtwo,
                                userID: allRequest[index].receiverId,
                              );
                              await FirebaseFirestore.instance
                                  .collection("Friends")
                                  .doc(uidtwo)
                                  .set(modeltwo.toMap());

                              QuerySnapshot snapshot = await FirebaseFirestore
                                  .instance
                                  .collection("request")
                                  .where("senderId",
                                      isEqualTo: allRequest[index].senderId)
                                  .where("receiverId",
                                      isEqualTo: allRequest[index].receiverId)
                                  .get();
                              for (var doc in snapshot.docs) {
                                await FirebaseFirestore.instance
                                    .collection("request")
                                    .doc(doc.id)
                                    .delete();
                              }
                              setState(() {
                                allRequest.removeAt(index);
                              });
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      "Congratulations you become friends!")));
                            },
                            child: const Text("Accept Request")),
                      );
                    }))
      ],
    )));
  }
}
