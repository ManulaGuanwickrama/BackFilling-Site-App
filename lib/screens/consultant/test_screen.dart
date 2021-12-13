import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_try_backfilling/constants.dart';
import 'package:first_try_backfilling/models/project_files/test.dart';
import 'package:first_try_backfilling/screens/screen_arguments/screen_arguments.dart';
import 'package:first_try_backfilling/sevices/database.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  static const id = 'testScreen';

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  DatabaseService databaseService = DatabaseService('projects');

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as TestEnterScreenArguments;
    /*
    List<String> details = test.testDetailsToString();
    List<Text> textList = [];
    for (String detail in details) {
      textList.add(Text(detail));
    }
    */
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        title: Text('Test'),
      ),
      body: FutureBuilder(
        future: databaseService.getTestDetails(
            args.projectID, args.sectionID.toString(), args.layerID.toString()),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Test test =
                Test.getFromMap(snapshot.data!.data() as Map<String, dynamic>);
            List<String> details = test.testDetailsToString();
            List<Text> textList = [];
            for (String detail in details) {
              textList.add(Text(
                detail,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ));
            }

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: textList,
              ),
            );
          }
          return Text("loading");
        },
      ),
    );
  }
}
