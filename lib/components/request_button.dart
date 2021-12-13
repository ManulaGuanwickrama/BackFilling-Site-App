import 'package:first_try_backfilling/screens/consultant/test_enter_screen.dart';
import 'package:first_try_backfilling/screens/screen_arguments/screen_arguments.dart';
import 'package:flutter/material.dart';

class RequestButton extends StatelessWidget {
  final String projectName;
  final String projectID;
  final String sectionID;
  final String layerID;

  RequestButton(
      {required this.projectName,
      required this.projectID,
      required this.sectionID,
      required this.layerID});
  //ProjectBubble({required this.projectName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            TestEnterScreen.id,
            arguments: TestEnterScreenArguments(
              projectID,
              int.parse(sectionID),
              int.parse(layerID),
            ),
          );
        },
        child: Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.blueAccent,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Project: ' + projectName,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Section: ' + sectionID,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'Layer: ' + layerID,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
