import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_try_backfilling/components/section_button.dart';
import 'package:first_try_backfilling/screens/client/client_layer_screen.dart';
import 'package:first_try_backfilling/screens/constructor/constructor_layer_screen.dart';
import 'package:first_try_backfilling/screens/screen_arguments/screen_arguments.dart';
import 'package:first_try_backfilling/screens/welcome_screen.dart';
import 'package:first_try_backfilling/sevices/database.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'consultant/consultant_layers_screen.dart';

class SectionsScreen extends StatefulWidget {
  static final String id = 'sectionsScreen';
  @override
  _SectionsScreenState createState() => _SectionsScreenState();
}

class _SectionsScreenState extends State<SectionsScreen> {
  DatabaseService database = DatabaseService('projects');
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as SectionsScreenArguments;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        title: Text('Sections'),
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
                stream: database.getDataFromSubCollection(
                  args.projectID,
                  'sections',
                  'sectionID',
                ),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.lightBlueAccent,
                      ),
                    );
                  }
                  final sections = snapshot.data!.docs;
                  List<SectionButton> sectionWidgets = [];
                  for (var section in sections) {
                    final sectionID = section.get('sectionID');
                    final start = section.get('start');
                    final finish = section.get('finish');
                    final depth = section.get('depth');
                    final numOfLayers = section.get('numOfLayers');
                    final numberOfCompleteLayers =
                        section.get('numberOfCompleteLayers');
                    final sectionWidget = SectionButton(
                      sectionID: sectionID,
                      start: start,
                      finish: finish,
                      depth: depth,
                      numOfLayers: numOfLayers,
                      numberOfCompleteLayers: numberOfCompleteLayers,
                      onPress: () {
                        print('\n\n\n' + args.character + '\n\n\n');
                        if (args.character == 'consultant') {
                          Navigator.pushNamed(
                            context,
                            ConsultantLayersScreen.id,
                            arguments: LayersScreenArguments(
                                args.projectID, section.get('sectionID')),
                          );
                        } else if (args.character == 'client') {
                          Navigator.pushNamed(
                            context,
                            ClientLayersScreen.id,
                            arguments: LayersScreenArguments(
                                args.projectID, section.get('sectionID')),
                          );
                        } else {
                          Navigator.pushNamed(
                            context,
                            ConstructorLayersScreen.id,
                            arguments: LayersScreenArguments(
                                args.projectID, section.get('sectionID')),
                          );
                        }
                      },
                    );
                    sectionWidgets.add(sectionWidget);
                  }
                  return Expanded(
                    child: ListView(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
                      children: sectionWidgets,
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
