import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_try_backfilling/components/rounded_button.dart';
import 'package:first_try_backfilling/components/secondary_button.dart';
import 'package:first_try_backfilling/constants.dart';
import 'package:first_try_backfilling/screens/consultant/create_project.dart';
import 'package:first_try_backfilling/screens/consultant/requests_screen.dart';
import 'package:first_try_backfilling/screens/projects_screen.dart';
import 'package:first_try_backfilling/screens/screen_arguments/screen_arguments.dart';
import 'package:first_try_backfilling/screens/user_page.dart';
import 'package:first_try_backfilling/sevices/requests_databse.dart';
import 'package:first_try_backfilling/sevices/user_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:badges/badges.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../welcome_screen.dart';

class ConsultantHomePage extends StatefulWidget {
  static String id = 'consultantHomePage';
  @override
  _ConsultantHomePageState createState() => _ConsultantHomePageState();
}

class _ConsultantHomePageState extends State<ConsultantHomePage> {
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;
  final RequestsDatabase requestsDatabase = RequestsDatabase();

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
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        title: Center(child: Text('Home')),
        actions: [
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
              Navigator.popUntil(
                  context, ModalRoute.withName(WelcomeScreen.id));
            },
          ),
        ],
      ),
      //backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('assets/soilLogo.png'),
                    height: 160.0,
                    width: 160.0,
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                RoundedButton(
                  clr: Colors.lightBlueAccent,
                  title: 'Create Project',
                  onPressFunction: () {
                    Navigator.pushNamed(context, CreateProjectScreen.id,
                        arguments:
                            CreateProjectScreenArguments(loggedInUser.uid));
                  },
                ),
                RoundedButton(
                  clr: Colors.blueAccent,
                  title: 'View Projects',
                  onPressFunction: () {
                    /* Navigator.pushNamed(context, ProjectsScreen.id,
                        arguments: ProjectScreenArguments(loggedInUser.uid));*/
                    Navigator.pushNamed(context, ProjectsScreen.id,
                        arguments: ProjectScreenArguments('consultant'));
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
              ],
            ),
            StreamBuilder<QuerySnapshot>(
                stream: requestsDatabase.getRequests(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.lightBlueAccent,
                      ),
                    );
                  }
                  final requests = snapshot.data!.size;
                  return Badge(
                    position: BadgePosition.topEnd(top: 4, end: -4),
                    badgeContent: Text(
                      requests.toString(),
                      style: TextStyle(fontSize: 20.0),
                    ),
                    child: SecondaryButton(
                      clr: Color(0xff2b2b2b),
                      title: 'Requests',
                      onPressFunction: () {
                        /* Navigator.pushNamed(context, ProjectsScreen.id,
                          arguments: ProjectScreenArguments(loggedInUser.uid));*/
                        Navigator.pushNamed(context, RequestsScreen.id);
                      },
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
