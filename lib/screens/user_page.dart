import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_try_backfilling/screens/screen_arguments/screen_arguments.dart';
import 'package:first_try_backfilling/sevices/user_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants.dart';

class UserPage extends StatelessWidget {
  static const id = 'UserPage';
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as UserScreenArguments;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text(args.firstName + ' ' + args.lastName),
        centerTitle: true,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: CircleAvatar(
                  child: Icon(
                    FontAwesomeIcons.userAlt,
                    size: 60,
                  ),
                  radius: 60,
                ),
              ),
              SizedBox(height: 100),
              Text(
                args.firstName + ' ' + args.lastName,
                style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              Text(
                args.email,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}
