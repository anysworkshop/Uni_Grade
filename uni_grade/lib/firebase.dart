import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference brewCollection = Firestore.instance.collection('Students');

  Future<void> updateUserData(String name, String email, int number) async {
    return await brewCollection.document(uid).setData({
      'name': name,
      'email': email,
      'number': number,
    });
  }



}