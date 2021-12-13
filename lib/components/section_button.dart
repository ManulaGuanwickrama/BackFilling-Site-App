import 'package:flutter/material.dart';
import 'package:first_try_backfilling/models/project_files/distance.dart';

class SectionButton extends StatelessWidget {
  final int sectionID;
  final int start;
  final int finish;
  final int numberOfCompleteLayers;
  final int numOfLayers;
  final double depth;
  late final Distance dStart;
  late final Distance dFinish;
  final void Function() onPress;
  SectionButton({
    required this.sectionID,
    required this.onPress,
    required this.start,
    required this.finish,
    required this.depth,
    required this.numberOfCompleteLayers,
    required this.numOfLayers,
  }) {
    dStart = Distance.fromMeters(start);
    dFinish = Distance.fromMeters(finish);
  }

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
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 50.0,
                  width: 50.0,
                  //margin: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                  child: Center(
                    child: Text(
                      sectionID.toString(),
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 25.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Section : ' +
                          dStart.kilometers.toString() +
                          '+' +
                          dStart.meters.toString() +
                          ' : ' +
                          dFinish.kilometers.toString() +
                          '+' +
                          dFinish.meters.toString(),
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Text(
                          'Completed layers : ',
                          style: TextStyle(
                              color: Colors.yellowAccent, fontSize: 12.0),
                        ),
                        Text(
                          numberOfCompleteLayers.toString(),
                          style: TextStyle(
                              color: Colors.greenAccent, fontSize: 12.0),
                        ),
                        Text(
                          '/' + numOfLayers.toString(),
                          style: TextStyle(
                              color: Colors.pinkAccent, fontSize: 12.0),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'Depth' + depth.toString() + 'm',
                          style:
                              TextStyle(fontSize: 10.0, color: Colors.black54),
                        ),
                      ],
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
