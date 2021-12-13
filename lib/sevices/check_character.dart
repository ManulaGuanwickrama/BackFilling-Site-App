import 'package:first_try_backfilling/sevices/user_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../sevices/database.dart';

final String uid = FirebaseAuth.instance.currentUser!.uid;

class CheckCharacter {
  String character;
  UserDatabase userDatabase = UserDatabase(uid);

  CheckCharacter(this.character);

  bool check() {
    if (character == userDatabase.getCharacter()) {
      return true;
    } else
      return false;
  }
}
