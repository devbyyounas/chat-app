import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_project/model.dart';
import 'package:my_project/sendreq_model.dart';
import 'package:my_project/staticdata.dart';
import 'package:uuid/uuid.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<UserModel> allUSers = [];
  getAllUsers() async {
    allUSers.clear();
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection("users").get();
    for (var user in snapshot.docs) {
      UserModel model = UserModel.fromMap(user.data() as Map<String, dynamic>);
      setState(() {
        allUSers.add(model);
      });
    }
  }

  @override
  void initState() {
    getAllUsers();
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
        title: const Center(
          child: Text(
            "Home",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        actions: const [CircleAvatar()],
      ),
      body: Stack(
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
              height: height * 0.65,
              width: width,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: ListView.builder(
                  itemCount: allUSers.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const CircleAvatar(
                        radius: 30,
                      ),
                      title: Text(allUSers[index].name!),
                      subtitle: Text(allUSers[index].email!),
                      trailing: ElevatedButton(
                          onPressed: () async {
                            Uuid uid = Uuid();
                            String uniquId = uid.v4();
                            SendRequest sendRequest = SendRequest(
                              receiverId: allUSers[index].userID,
                              receiverName: allUSers[index].name,
                              senderName: StaticData.userModel!.name,
                              senderId: StaticData.userModel!.userID,
                              uniqueId: uniquId,
                            );
                            await FirebaseFirestore.instance
                                .collection("request")
                                .doc(uniquId)
                                .set(sendRequest.toMap());
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Request send!!")));
                          },
                          child: const Text("Req send")),
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }
}
