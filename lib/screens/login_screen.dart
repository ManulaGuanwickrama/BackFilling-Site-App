import 'package:first_try_backfilling/screens/constructor/contructor_home_page.dart';
import 'package:first_try_backfilling/sevices/user_database.dart';
import '../components/rounded_button.dart';
import '../constants.dart';
import '../screens/consultant/consultant_home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'client/client_home_page.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'logginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _showSpinner = false;
  final _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';
  bool isValid = true;

  Widget validatorWidget() {
    if (isValid) {
      return SizedBox(
        height: 5.0,
      );
    } else {
      return Text(
        'Invalid Email or password',
        style: TextStyle(color: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // final args = ModalRoute.of(context)!.settings.arguments as CurrentUser;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
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
              validatorWidget(),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextFieldDecorationDecoration.copyWith(
                    hintText: 'Enter your email'),
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
                    hintText: 'Enter your password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                clr: Colors.lightBlueAccent,
                title: 'Log In',
                onPressFunction: () async {
                  setState(() {
                    _showSpinner = true;
                  });
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                    if (user != null) {
                      String charc =
                          await UserDatabase(user.user!.uid).getCharacter();
                      if (charc == 'consultant') {
                        Navigator.pushNamed(context, ConsultantHomePage.id);
                      } else if (charc == 'client') {
                        Navigator.pushNamed(context, ClientHomePage.id);
                      } else {
                        Navigator.pushNamed(context, ConstructorHomePage.id);
                      }
                    }
                    setState(() {
                      _showSpinner = false;
                    });
                  } catch (e) {
                    setState(() {
                      isValid = false;
                      _showSpinner = false;
                    });
                    print(
                        '---------error in loggin---------------------------');
                    print(e);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
