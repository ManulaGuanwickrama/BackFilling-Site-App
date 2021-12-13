import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_try_backfilling/components/rounded_button.dart';
import 'package:first_try_backfilling/screens/projects_screen.dart';
import 'package:first_try_backfilling/screens/screen_arguments/screen_arguments.dart';
import 'package:first_try_backfilling/sevices/user_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants.dart';
import '../user_page.dart';
import '../welcome_screen.dart';

class ClientHomePage extends StatefulWidget {
  static const String id = 'clientHomePage';

  @override
  _ClientHomePageState createState() => _ClientHomePageState();
}

class _ClientHomePageState extends State<ClientHomePage> {
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
      print(loggedInUser.email);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar:
          AppBar(backgroundColor: kAppBarColor, title: Text('Home'), actions: [
        GestureDetector(
          child: CircleAvatar(
            backgroundColor: Colors.lightBlueAccent,
            child: Icon(
              FontAwesomeIcons.userAlt,
              color: Colors.white,
            ),
          ),
          onTap: () async {
            Map<String, dynamic> userData =
                await UserDatabase(loggedInUser.uid).getUserData();

            Navigator.pushNamed(
              context,
              UserPage.id,
              arguments: UserScreenArguments(
                userData['lastName'].toString(),
                userData['firstName'].toString(),
                loggedInUser.email.toString(),
              ),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.logout),
          tooltip: 'log out',
          onPressed: () {
            Navigator.popUntil(context, ModalRoute.withName(WelcomeScreen.id));
          },
        ),
      ]),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
            tag: 'logo',
            child: Container(
              child: Image.asset('assets/soilLogo.png'),
              height: 160.0,
              width: 160.0,
            ),
          ),
          Center(
            child: RoundedButton(
              clr: Colors.blue,
              title: 'View Projects',
              onPressFunction: () {
                Navigator.pushNamed(
                  context,
                  ProjectsScreen.id,
                  arguments: ProjectScreenArguments('client'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
