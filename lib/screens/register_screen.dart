import 'package:first_try_backfilling/sevices/user_database.dart';
import 'package:email_validator/email_validator.dart';
import '../components/rounded_button.dart';
import '../constants.dart';
import '../screens/consultant/consultant_home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'client/client_home_page.dart';
import 'constructor/contructor_home_page.dart';

enum Character { client, consultant, constructor }

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registrationScreen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';
  String firstName = '';
  String lastName = '';
  bool isValid = true;
  Character? character = Character.consultant;

  Widget emailIndicator() {
    if (isValid) {
      return SizedBox(
        height: 10.0,
      );
    } else {
      return Row(
        children: [
          SizedBox(
            width: 20.0,
          ),
          Text(
            'Email format is invalid or password is less than 6 characters, please re-enter',
            style: TextStyle(fontSize: 12.0, color: Colors.red),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 100.0,
                ),
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      height: 80.0,
                      child: Image.asset('assets/soilLogo.png'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 36.0,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    firstName = value;
                  },
                  decoration: kTextFieldDecorationDecoration.copyWith(
                    hintText: 'First Name',
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    lastName = value;
                  },
                  decoration: kTextFieldDecorationDecoration.copyWith(
                    hintText: 'Last Name',
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                ListTile(
                  title: const Text('Client'),
                  leading: Radio<Character>(
                    value: Character.client,
                    groupValue: character,
                    onChanged: (Character? value) {
                      setState(() {
                        character = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Consultant'),
                  leading: Radio<Character>(
                    value: Character.consultant,
                    groupValue: character,
                    onChanged: (Character? value) {
                      setState(() {
                        character = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Constructor'),
                  leading: Radio<Character>(
                    value: Character.constructor,
                    groupValue: character,
                    onChanged: (Character? value) {
                      setState(() {
                        character = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                emailIndicator(),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kTextFieldDecorationDecoration.copyWith(
                    hintText: 'Enter your email',
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: kTextFieldDecorationDecoration.copyWith(
                    hintText: 'password(Should be more than 5 characters)',
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                RoundedButton(
                  clr: Colors.blueAccent,
                  title: 'Register',
                  onPressFunction: () async {
                    if (EmailValidator.validate(email)) {
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                          email: email,
                          password: password,
                        );
                        await UserDatabase(newUser.user!.uid).updateUserData(
                            firstName,
                            lastName,
                            character.toString().substring(
                                character.toString().indexOf('.') + 1));

                        if (character.toString().substring(
                                character.toString().indexOf('.') + 1) ==
                            'consultant') {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, ConsultantHomePage.id);
                        } else if (character.toString().substring(
                                character.toString().indexOf('.') + 1) ==
                            'client') {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, ClientHomePage.id);
                        } else {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, ConstructorHomePage.id);
                        }

                        setState(() {
                          showSpinner = false;
                        });
                      } catch (e) {
                        setState(() {
                          showSpinner = false;
                          isValid = false;
                        });
                        print(e);
                      }
                    } else {
                      setState(() {
                        showSpinner = false;
                        isValid = false;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
