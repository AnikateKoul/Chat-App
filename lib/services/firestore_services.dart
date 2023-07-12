import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreServices {
  var db = FirebaseFirestore.instance;
  getData() async {
    final ref = await db.collection('Chats').doc('myChat').get();
    final chats = ref.data();
    print("The chats are $chats");
    
  }

  getStream() {
    return db.collection('Chats').snapshots();
  }
  
}