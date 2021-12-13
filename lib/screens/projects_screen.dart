import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_try_backfilling/components/project_button.dart';
import 'package:first_try_backfilling/screens/sections_screen.dart';
import 'package:first_try_backfilling/screens/welcome_screen.dart';
import 'package:first_try_backfilling/sevices/database.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'screen_arguments/screen_arguments.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProjectsScreen extends StatefulWidget {
  static const String id = 'projectScreen';
  @override
  _ProjectsScreenState createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  DatabaseService database = DatabaseService('projects');
  String totalLayerRatio = '';

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as ProjectScreenArguments;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        title: Text('Projects'),
        actions: [
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
                stream: database.getData('name'),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.lightBlueAccent,
                      ),
                    );
                  }
                  final projects = snapshot.data!.docs;
                  List<ProjectButton> projectWidgets = [];
                  for (var project in projects) {
                    final projectName = project.get('name');
                    final noOfSections = project.get('numberOfSections');
                    final numOfCompleteSections =
                        project.get('numberOfCompleteSections');
                    final progressSnapshot =
                        database.getProgress(project.id, 'sections');

                    final projectWidget = ProjectButton(
                      projectName: projectName,
                      numberOfSections: noOfSections,
                      numOfCompleteSections: numOfCompleteSections,
                      onPress: () {
                        Navigator.pushNamed(
                          context,
                          SectionsScreen.id,
                          arguments: SectionsScreenArguments(
                              args.character, project.id),
                        );
                      },
                      progressSnapshot: progressSnapshot,
                    );
                    projectWidgets.add(projectWidget);
                  }
                  return Expanded(
                    child: ListView(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
                      children: projectWidgets,
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
