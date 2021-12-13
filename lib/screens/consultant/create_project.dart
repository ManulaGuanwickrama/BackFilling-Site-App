import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_try_backfilling/models/project_files/distance.dart';
import 'package:first_try_backfilling/models/project_files/project.dart';
import 'package:first_try_backfilling/constants.dart';
import 'package:first_try_backfilling/screens/screen_arguments/screen_arguments.dart';
import 'package:first_try_backfilling/sevices/Project_database.dart';
import 'package:flutter/material.dart';
import 'package:first_try_backfilling/components/rounded_button.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../projects_screen.dart';

class CreateProjectScreen extends StatefulWidget {
  static const String id = 'create_Project_Screen';
  @override
  _CreateProjectScreenState createState() => _CreateProjectScreenState();
}

class _CreateProjectScreenState extends State<CreateProjectScreen> {
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  bool _showSpinner = false;
  String name = '';
  int length_killometers = 0;
  int length_meters = 0;
  double depth = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        title: Text('Create new Project'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 24.0,
                ),
                TextField(
                  onChanged: (value) {
                    name = value;
                  },
                  decoration: kTextFieldDecorationDecoration.copyWith(
                    labelText: 'Enter the project Name',
                    hintText: 'Name',
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                Text('Enter length :'),
                TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    length_killometers = int.parse(value);
                  },
                  decoration: kTextFieldDecorationDecoration.copyWith(
                    hintText: 'Killometers',
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    length_meters = int.parse(value);
                  },
                  decoration: kTextFieldDecorationDecoration.copyWith(
                    hintText: 'Meters',
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                Text('Enter depth :'),
                TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    depth = double.parse(value);
                  },
                  decoration: kTextFieldDecorationDecoration.copyWith(
                    hintText: 'Meters',
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                RoundedButton(
                  clr: kMediumColor,
                  title: 'Create',
                  onPressFunction: () async {
                    Project project = Project(
                        name: name,
                        length: Distance(
                            meters: length_meters,
                            kilometers: length_killometers),
                        depth: depth);
                    CreateProjectDatabase database =
                        CreateProjectDatabase(uid, project);
                    setState(() {
                      _showSpinner = true;
                    });
                    try {
                      database.createProject();
                      Navigator.pop(context);
                      Navigator.pushNamed(context, ProjectsScreen.id,
                          arguments: ProjectScreenArguments('consultant'));
                      setState(() {
                        _showSpinner = false;
                      });
                    } catch (e) {
                      print(e);
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
