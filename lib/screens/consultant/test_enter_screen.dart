import 'package:first_try_backfilling/components/rounded_button.dart';
import 'package:first_try_backfilling/models/project_files/test.dart';
import 'package:first_try_backfilling/screens/screen_arguments/screen_arguments.dart';
import 'package:first_try_backfilling/sevices/database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../constants.dart';
import 'package:charcode/charcode.dart';

class TestEnterScreen extends StatefulWidget {
  static const String id = 'TestEnterScreen';

  @override
  _TestEnterScreenState createState() => _TestEnterScreenState();
}

class _TestEnterScreenState extends State<TestEnterScreen> {
  Test test = Test();
  @override
  Widget build(BuildContext context) {
    test.date = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
    final args =
        ModalRoute.of(context)!.settings.arguments as TestEnterScreenArguments;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        title: Text('Test'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // For hole depth in millimeters
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  test.massOfWetSoil = int.parse(value);
                },
                decoration: kTestInputFieldDecoration.copyWith(
                    hintText: 'grams', labelText: 'Mass of wet soil'),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  test.massOfSandBefore = int.parse(value);
                },
                decoration: kTestInputFieldDecoration.copyWith(
                    hintText: 'grams',
                    labelText: 'Mass of sand before pouring to hole'),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  test.massOfSandRemaining = int.parse(value);
                },
                decoration: kTestInputFieldDecoration.copyWith(
                    hintText: 'grams',
                    labelText: 'Mass of sand remaining after pouring'),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  test.massOfSandInCone = int.parse(value);
                },
                decoration: kTestInputFieldDecoration.copyWith(
                    hintText: 'grams', labelText: 'Mass of sand in cone'),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  test.volumeOfTheHole = int.parse(value);
                },
                decoration: kTestInputFieldDecoration.copyWith(
                    hintText: 'cm' + String.fromCharCode($sup3),
                    labelText: 'Volume of the hole'),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  test.massOfWetSoilWithTray = int.parse(value);
                },
                decoration: kTestInputFieldDecoration.copyWith(
                    hintText: 'grams', labelText: 'Mass of wet soil + tray'),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  test.massOfDrySoilWithTray = int.parse(value);
                },
                decoration: kTestInputFieldDecoration.copyWith(
                    hintText: 'grams', labelText: 'Mass of dry soil + tray'),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  test.massOfTray = int.parse(value);
                },
                decoration: kTestInputFieldDecoration.copyWith(
                    hintText: 'grams', labelText: 'Mass of tray'),
              ),
              SizedBox(
                height: 10.0,
              ),

              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  test.maximumDryDensity = double.parse(value);
                },
                decoration: kTestInputFieldDecoration.copyWith(
                    hintText: 'Mg/m' + String.fromCharCode($sup3),
                    labelText: 'Maximum Dry Density(MDD)'),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  test.optimumMoistureContent = double.parse(value);
                },
                decoration: kTestInputFieldDecoration.copyWith(
                    hintText: '%', labelText: 'Optimum Moisture Content(OMC)'),
              ),
              SizedBox(
                height: 10.0,
              ),

              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  test.requiredCompactionDegree = double.parse(value);
                },
                decoration: kTestInputFieldDecoration.copyWith(
                    hintText: '%', labelText: 'Required Compaction Degree'),
              ),
              SizedBox(
                height: 10.0,
              ),

              RoundedButton(
                  clr: Colors.blueAccent,
                  title: 'Enter Test Details',
                  onPressFunction: () {
                    test.execute();
                    DatabaseService('projects').addTest(
                      test.toMap(),
                      args.projectID,
                      args.sectionID.toString(),
                      args.layerID.toString(),
                    );
                    if (test.testResult) {
                      DatabaseService('projects').testPass(
                        args.projectID,
                        args.sectionID.toString(),
                        args.layerID.toString(),
                      );
                    } else {
                      DatabaseService('projects').testFail(
                        args.projectID,
                        args.sectionID.toString(),
                        args.layerID.toString(),
                      );
                    }
                    Navigator.pop(context);
                  }),
              // ##
            ],
          ),
        ),
      ),
    );
  }
}

class Value {
  num number;

  Value(this.number);
}

class NumberInputField extends StatelessWidget {
  late final Value value;
  final String hintText;

  NumberInputField({required this.value, required this.hintText});

  @override
  Widget build(BuildContext context) {
    Test test = Test();
    return TextField(
      keyboardType: TextInputType.number,
      onChanged: (value) {
        this.value.number = num.parse(value);
      },
      decoration: kTextFieldDecorationDecoration.copyWith(hintText: hintText),
    );
  }
}
