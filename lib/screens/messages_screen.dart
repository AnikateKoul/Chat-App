import 'dart:async';

import 'package:chat_app/services/firestore_services.dart';
import 'package:chat_app/services/flask_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  StreamController messageController = StreamController();

  loadPosts() async {
    FlaskServices().getData().then((res) async {
      messageController.add(res);
      return res;
    });
  }

  @override
  void initState() {
    print("Loaded");
    FireStoreServices().getData();
    loadPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        color: Colors.white,
        height: screenHeight,
        child: StreamBuilder(stream: FireStoreServices().getStream(), builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(snapshot.hasData) {
            print(snapshot.data!.docs.first);
            return ListView(
        children: snapshot.data!.docs.map((document) {
          return Center(
            child: Container(
              width: MediaQuery.of(context).size.width / 1.2,
              height: MediaQuery.of(context).size.height / 6,
              child: ListView.builder(itemBuilder: (context, index) {
                return Text(document['a'][index]);
              }, itemCount: document['a'].length,)
            ),
          );
        }).toList(),
      );
          }
          else {
            return const Center(child: CircularProgressIndicator(),);
          }
        },),
      ),
    );
  }
}