import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_try_backfilling/constants.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProjectButton extends StatelessWidget {
  final String projectName;
  final int numberOfSections;
  final int numOfCompleteSections;
  final Future<QuerySnapshot<Map<String, dynamic>>> progressSnapshot;
  final void Function() onPress;

  ProjectButton({
    required this.projectName,
    required this.numberOfSections,
    required this.numOfCompleteSections,
    required this.onPress,
    required this.progressSnapshot,
  });
  //ProjectBubble({required this.projectName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onPress,
        child: Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.blueAccent,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 200,
                      child: Text(
                        projectName,
                        style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Completed sections : ',
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                        Text(
                          numOfCompleteSections.toString(),
                          style: TextStyle(
                              color: Colors.greenAccent, fontSize: 16.0),
                        ),
                        Text(
                          '/' + numberOfSections.toString(),
                          style: TextStyle(
                              color: Colors.pinkAccent, fontSize: 16.0),
                        ),
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: SizedBox(
                    width: 5.0,
                  ),
                ),
                FutureBuilder(
                  future: progressSnapshot,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    num totalLayers = 0;
                    num completeLayers = 0;
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("Loading");
                    }
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.lightBlueAccent,
                        ),
                      );
                    }
                    snapshot.data!.docs.forEach((doc) {
                      totalLayers = totalLayers + doc['numOfLayers'];
                      completeLayers =
                          completeLayers + doc['numberOfCompleteLayers'];
                    });
                    double progress = completeLayers / totalLayers;

                    return CircularPercentIndicator(
                      radius: 80.0,
                      lineWidth: 8.0,
                      percent: progress,
                      center: Text(
                        (progress * 100).toStringAsFixed(0) + '%',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      circularStrokeCap: CircularStrokeCap.round,
                      backgroundColor: Colors.white,
                      progressColor: Color(0xff010101),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
