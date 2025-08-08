import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_project/friends_model.dart';
import 'package:http/http.dart' as http;
import 'package:my_project/video_play.dart';
import 'package:path/path.dart';
import 'package:my_project/staticdata.dart';

class ChatScreen extends StatefulWidget {
  final String chatRoomId;
  final FriendModel profileModel;
  const ChatScreen(
      {super.key, required this.chatRoomId, required this.profileModel});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  http.Response? response;
  TextEditingController _messageController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();
  }

  File? _photo;
  File? _video;
  final ImagePicker _picker = ImagePicker();
  Future imageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('no image selected');
      }
    });
  }

  Future uploadFile() async {
    if (_photo == null) return;
    final fileName = basename(_photo!.path);
    final destination = 'files/$fileName';

    try {
      // final ref = FirebaseStorage.instance.ref(destination).child('file/');
      final ref = FirebaseStorage.instance.ref(destination);
      await ref.putFile(_photo!);
      String url = await ref.getDownloadURL();
      // print(url);
      onsendMessage(url, "img");
    } catch (e) {
      print('error occured');
    }
  }

  Future pickVideoFromGallery() async {
    final pickedVideo = await _picker.pickVideo(source: ImageSource.gallery);
    if (pickedVideo != null) {
      setState(() {
        _video = File(pickedVideo.path);
      });
      uploadVideoFile();
    } else {
      print('No video selected.');
    }
  }

  Future uploadVideoFile() async {
    if (_video == null) return;
    final fileName = basename(_video!.path);

    try {
      final ref =
          FirebaseStorage.instance.ref().child('/younasvideo').child(fileName);

      await ref.putFile(_video!);
      String url = await ref.getDownloadURL();
      onsendMessage(url, "video");
    } catch (e) {
      print('Video upload error: $e');
    }
  }

  void onsendMessage(String msg, String type) async {
    if (msg.isNotEmpty) {
      Map<String, dynamic> messages = {
        "sendBy": StaticData.userModel!.name,
        "message": msg,
        "time": FieldValue.serverTimestamp(),
        "type": type
      };
      await _firestore
          .collection("chatroom")
          .doc(widget.chatRoomId)
          .collection('chats')
          .add(messages);
      if (type == "text") {
        _messageController.clear();
      }
    } else {
      print("enter some text");
    }
  }

  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: height,
          width: width,
          child: Column(
            children: [
              Container(
                color: Colors.green[100],
                height: height * 0.04,
              ),
              Container(
                height: height * 0.08,
                width: width,
                decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                child: Padding(
                  padding:
                      EdgeInsets.only(right: width * 0.02, left: width * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: height * 0.05,
                        width: width * 0.12,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.person,
                          color: Colors.red[200],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${widget.profileModel.recieverName}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                      Expanded(
                          child: SizedBox(
                        width: width,
                      )),
                      InkWell(
                        onTap: () {},
                        child: Icon(
                          Icons.call,
                          size: width * 0.07,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Icon(
                          Icons.video_call,
                          size: width * 0.07,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: width * 0.02,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: SizedBox(
                child: StreamBuilder<QuerySnapshot>(
                  stream: _firestore
                      .collection('chatroom')
                      .doc(widget.chatRoomId)
                      .collection('chats')
                      .orderBy('time', descending: false)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.data != null) {
                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> map =
                                snapshot.data!.docs[index].data()
                                    as Map<String, dynamic>;
                            return messages(MediaQuery.of(context).size, map);
                          });
                    } else {
                      return Container();
                    }
                  },
                ),
              )),
              Divider(
                color: Colors.red,
              ),
              SizedBox(
                height: height * 0.07,
                width: width,
                child: Padding(
                  padding:
                      EdgeInsets.only(left: width * 0.03, right: width * 0.01),
                  child: Row(
                    children: [
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red[100],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: width * 0.02),
                          child: Center(
                            child: TextField(
                              controller: _messageController,
                              decoration: const InputDecoration(
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                      )),
                      SizedBox(
                        width: width * 0.01,
                      ),
                      InkWell(
                        onTap: () {
                          if (_messageController.text.trim().isNotEmpty) {
                            onsendMessage(
                                _messageController.text.trim(), "text");
                          } else {
                            imageFromGallery();
                          }
                          //onsendMessage();
                        },
                        child: Container(
                          height: height,
                          width: width * 0.14,
                          decoration: BoxDecoration(
                            color: Colors.red[400],
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.image,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (_messageController.text.trim().isNotEmpty) {
                            onsendMessage(
                                _messageController.text.trim(), "text");
                          } else {
                            pickVideoFromGallery();
                          }
                          //onsendMessage();
                        },
                        child: Container(
                          height: height,
                          width: width * 0.14,
                          decoration: BoxDecoration(
                            color: Colors.red[400],
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.videocam,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          onsendMessage(_messageController.text, "text");
                        },
                        child: Container(
                          height: height,
                          width: width * 0.14,
                          decoration: BoxDecoration(
                            color: Colors.red[400],
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.send,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.01,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget messages(Size size, Map<String, dynamic> map) {
    return Container(
      width: size.width,
      alignment: map['sendBy'] == StaticData.userModel!.name
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: map['sendBy'] == StaticData.userModel!.name
              ? Colors.red
              : Colors.red[100],
        ),
        child: map['type'] == 'img'
            ? Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(map['message']))),
              )
            : map['type'] == "video"
                ? VideoMessage(videoUrl: map['message'])
                : Text(
                    map['message'],
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: map['sendBy'] == StaticData.userModel!.name
                            ? Colors.white
                            : Colors.black),
                  ),
      ),
    );
  }
}
