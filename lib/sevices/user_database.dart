import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class UserDatabase {
  final String uid;
  static final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  UserDatabase(this.uid);

  Future updateUserData(
      String firstName, String lastName, String character) async {
    return await users.doc(uid).set({
      'firstName': firstName,
      'lastName': lastName,
      'character': character,
    });
  }

  Future getUserData() async {
    final userData = await users.doc(uid).get();
    return userData.data(); //Returns a Map of firstName, lastName, character
  }

  Future getCharacter() async {
    final userData = await users.doc(uid).get();
    try {
      return userData.get(FieldPath(['character']));
    } catch (e, s) {
      print(
          '\n\n------------------------------------------------------------\n');
      print('There was an error while getting the character of the user');
      print('Happened in user_database.dart');
      print(s);
    }
  }
}
