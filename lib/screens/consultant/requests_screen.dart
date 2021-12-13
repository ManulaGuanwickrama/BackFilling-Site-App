import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_try_backfilling/components/request_button.dart';
import 'package:first_try_backfilling/sevices/requests_databse.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class RequestsScreen extends StatefulWidget {
  static const String id = 'requestsScreen';

  @override
  _RequestsScreenState createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  RequestsDatabase requestsDatabase = RequestsDatabase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        title: Text('Requests'),
      ),
      //backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
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
                  final requests = snapshot.data!.docs;
                  List<RequestButton> requestWidgets = [];
                  for (var request in requests) {
                    final projectName = request.get('projectName');
                    final projectID = request.get('projectID');
                    final sectionID = request.get('sectionID');
                    final laterID = request.get('layerID');

                    final requestWidget = RequestButton(
                      projectName: projectName,
                      projectID: projectID,
                      sectionID: sectionID,
                      layerID: laterID,
                    );
                    requestWidgets.add(requestWidget);
                  }
                  return Expanded(
                    child: ListView(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.0, vertical: 20),
                      children: requestWidgets,
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
