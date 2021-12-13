import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_try_backfilling/screens/consultant/test_screen.dart';
import 'package:first_try_backfilling/screens/screen_arguments/screen_arguments.dart';
import 'package:first_try_backfilling/sevices/database.dart';
import 'package:first_try_backfilling/sevices/requests_databse.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../constants.dart';
import '../welcome_screen.dart';

class ConstructorLayersScreen extends StatefulWidget {
  static final String id = 'constructorLayersScreen';
  @override
  _ConstructorLayersScreenState createState() =>
      _ConstructorLayersScreenState();
}

class _ConstructorLayersScreenState extends State<ConstructorLayersScreen> {
  DatabaseService database = DatabaseService('projects');
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as LayersScreenArguments;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        title: Text('Layers'),
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
        padding: EdgeInsets.symmetric(horizontal: 2.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
                stream: database.getDataFromHierarchyOfTwoSubCollections(
                    args.projectID,
                    'sections',
                    args.sectionID.toString(),
                    'layers',
                    'layerNumber'),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.lightBlueAccent,
                      ),
                    );
                  }
                  final sections = snapshot.data!.docs;
                  List<Widget> layerWidgets = [];
                  for (var section in sections) {
                    final int layerNumber = section.get('layerNumber');
                    final bool isTested = section.get('isTested');
                    final bool isOkay = section.get('isOkay');
                    final bool pending = section.get('pending');
                    final Widget layerWidget;
                    if (isTested && isOkay) {
                      layerWidget = TestPassedButton(
                          onPress: () {
                            Navigator.pushNamed(
                              context,
                              TestScreen.id,
                              arguments: TestEnterScreenArguments(
                                args.projectID,
                                args.sectionID,
                                layerNumber,
                              ),
                            );
                          },
                          layerNumber: layerNumber);
                    } else if (pending) {
                      layerWidget = PendingButton(layerNumber: layerNumber);
                    } else {
                      layerWidget = NotTestedButton(
                          onPress: () async {
                            try {
                              RequestsDatabase req = RequestsDatabase.withData(
                                  args.projectID,
                                  args.sectionID.toString(),
                                  layerNumber.toString());
                              await req.putRequest();
                            } catch (e) {
                              print('Error on requesting');
                              print('constructor layer screen');
                              print(e);
                            }
                          },
                          layerNumber: layerNumber);
                    }

                    layerWidgets.add(layerWidget);
                  }
                  return Expanded(
                    child: ListView(
                      padding:
                          EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                      children: layerWidgets,
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}

class TestPassedButton extends StatelessWidget {
  final void Function() onPress;
  final int layerNumber;

  TestPassedButton({required this.onPress, required this.layerNumber});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(10.0),
        color: kTestPassColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 50.0,
                width: 50.0,
                //margin: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: kTestPassCircleColor,
                ),
                child: Center(
                  child: Text(
                    layerNumber.toString(),
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: 20.0,
                ),
              ),
              Column(
                children: [
                  Text(
                    'Compaction Test\nPassed',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Icon(
                    Icons.check,
                    size: 20.0,
                  ),
                ],
              ),
              SizedBox(
                width: 20.0,
              ),
              GestureDetector(
                onTap: onPress,
                child: Column(children: [
                  Text('Test Details'),
                  Icon(
                    Icons.forward,
                    size: 30.0,
                  )
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NotTestedButton extends StatelessWidget {
  final void Function() onPress;
  final int layerNumber;

  NotTestedButton({required this.onPress, required this.layerNumber});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(10.0),
        color: kNotTestedColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 50.0,
                width: 50.0,
                //margin: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: kNotTestedCircleColor,
                ),
                child: Center(
                  child: Text(
                    layerNumber.toString(),
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: 20.0,
                ),
              ),
              GestureDetector(
                onTap: onPress,
                child: Column(
                  children: [
                    Text(
                      'Request',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Icon(
                      Icons.forward,
                      size: 30.0,
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RequestLoadingButton extends StatelessWidget {
  final void Function() onPress;
  final int layerNumber;

  RequestLoadingButton({required this.onPress, required this.layerNumber});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Color(0xff5f5f5f),
      highlightColor: Color(0xffb8b8b8),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xff5f5f5f),
            borderRadius: BorderRadius.circular(10.0),
          ),
          height: 70.0,
        ),
      ),
    );
  }
}

class PendingButton extends StatelessWidget {
  final int layerNumber;

  PendingButton({required this.layerNumber});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(10.0),
        color: kPendingColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 50.0,
                width: 50.0,
                //margin: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: kPendingCircleColor,
                ),
                child: Center(
                  child: Text(
                    layerNumber.toString(),
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: 20.0,
                ),
              ),
              Column(
                children: [
                  Text(
                    'Pending...',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Icon(
                    Icons.forward,
                    size: 30.0,
                  )
                ],
              ),
              SizedBox(
                width: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
