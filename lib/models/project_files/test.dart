import 'package:charcode/charcode.dart';

class Test {
  bool tested = false;
  bool testResult = false;

  late String date;
  final int holeDepth = 250;
  late int massOfWetSoil; //Mass of wet soil from the hole
  late int massOfSandBefore; //Mass Of Sand Before pouring to the hole
  late int
      massOfSandRemaining; //Mass Of Sand Remaining After pouring to the hole
  late int massOfSandInCone; //Mass of sand in cone
  late int
      massOfSandRequiredToFillTheHole; //Mass of sand required to fill The hole
  late int volumeOfTheHole;
  late double wetDensity;

  //late String trayNumber;
  late int massOfWetSoilWithTray;
  late int massOfDrySoilWithTray;
  late int massOfTray;
  late int massOfDrySoil;
  late int massOfWater;
  late double moistureContent;
  late double dryDensity;
  late double maximumDryDensity;
  late double optimumMoistureContent;
  late double compactionDegree;
  late double requiredCompactionDegree;

  Test();

  void execute() {
    tested = true;
    massOfSandRequiredToFillTheHole =
        massOfSandBefore - massOfSandRemaining - massOfSandInCone;
    massOfDrySoil = massOfDrySoilWithTray - massOfTray;
    massOfWater = (massOfWetSoilWithTray - massOfTray) - massOfDrySoil;
    moistureContent = (massOfWater / massOfDrySoil) * 100;
    wetDensity = massOfWetSoil / volumeOfTheHole;
    double bulkDensityOfSand =
        massOfSandRequiredToFillTheHole / volumeOfTheHole;
    double bulkDensityOfSoil = massOfWetSoil / volumeOfTheHole;
    dryDensity = (100 * bulkDensityOfSoil) / (100 + moistureContent);
    compactionDegree = (dryDensity / maximumDryDensity) * 100;
    tested = true;
    if (compactionDegree > requiredCompactionDegree)
      testResult = true;
    else
      testResult = false;
  }

  Test.getFromMap(Map<String, dynamic> data) {
    tested = data['tested'];
    testResult = data['testResult'];
    date = data['date'];
    //holeDepth = data['holeDepth'];
    massOfWetSoil = data['massOfWetSoil'];
    massOfSandBefore = data['massOfSandBefore'];
    massOfSandRemaining = data['massOfSandRemaining'];
    massOfSandInCone = data['massOfSandInCone'];
    massOfSandRequiredToFillTheHole = data['massOfSandRequiredToFillTheHole'];
    volumeOfTheHole = data['volumeOfTheHole'];
    wetDensity = data['wetDensity'];

    //trayNumber = data['trayNumber'];
    massOfWetSoilWithTray = data['massOfWetSoilWithTray'];
    massOfDrySoilWithTray = data['massOfDrySoilWithTray'];
    massOfTray = data['massOfTray'];
    massOfDrySoil = data['massOfDrySoil'];
    massOfWater = data['massOfWater'];
    moistureContent = data['moistureContent'];
    dryDensity = data['dryDensity'];
    maximumDryDensity = data['maximumDryDensity'];
    optimumMoistureContent = data['optimumMoistureContent'];
    compactionDegree = data['compactionDegree'];
    requiredCompactionDegree = data['requiredCompactionDegree'];
  }

  Map<String, dynamic> toMap() {
    return {
      'tested': tested,
      'testResult': testResult,
      'date': date,
      'holeDepth': holeDepth,
      'massOfWetSoil': massOfWetSoil,
      'massOfSandBefore': massOfSandBefore,
      'massOfSandRemaining': massOfSandRemaining,
      'massOfSandInCone': massOfSandInCone,
      'massOfSandRequiredToFillTheHole': massOfSandRequiredToFillTheHole,
      'volumeOfTheHole': volumeOfTheHole,
      'wetDensity': wetDensity,
      //'trayNumber': trayNumber,
      'massOfWetSoilWithTray': massOfWetSoilWithTray,
      'massOfDrySoilWithTray': massOfDrySoilWithTray,
      'massOfTray': massOfTray,
      'massOfDrySoil': massOfDrySoil,
      'massOfWater': massOfWater,
      'moistureContent': moistureContent,
      'dryDensity': dryDensity,
      'maximumDryDensity': maximumDryDensity,
      'optimumMoistureContent': optimumMoistureContent,
      'compactionDegree': compactionDegree,
      'requiredCompactionDegree': requiredCompactionDegree,
    };
  }

  List<String> testDetailsToString() {
    List<String> testDetails = [
      'Date : ' + date,
      'Depth of the hole(mm) : ' + holeDepth.toString(),
      'Mass of the wet soil from the hole(g) : ' + massOfWetSoil.toString(),
      'Mass of sand before pouring to hole(g) : ' + massOfSandBefore.toString(),
      'Mass of sand remaining after puring(g) : ' +
          massOfSandRemaining.toString(),
      'Mass of sand in cone(g) : ' + massOfSandInCone.toString(),
      'Mass required to fill the hole(g) : ' +
          massOfSandRequiredToFillTheHole.toString(),
      'Volume of the hole(cm' +
          String.fromCharCode($sup3) +
          ') : ' +
          volumeOfTheHole.toString(),
      'Wet density(Mg/m' +
          String.fromCharCode($sup3) +
          ') : ' +
          wetDensity.toStringAsFixed(4),
      'Mass of wet soil + tray(g) : ' + massOfWetSoilWithTray.toString(),
      'Mass of dry soil + tray(g) : ' + massOfDrySoilWithTray.toString(),
      'Mass of the tray(g) : ' + massOfTray.toString(),
      'Mass of dry soil(g) : ' + massOfDrySoil.toString(),
      'Mass of water (g): ' + massOfWater.toString(),
      'Moisture content(%) : ' + moistureContent.toStringAsFixed(4),
      'Dry density(Mg/m' +
          String.fromCharCode($sup3) +
          ') : ' +
          dryDensity.toStringAsFixed(4),
      'Maximum dry density(Mg/m' +
          String.fromCharCode($sup3) +
          ') : ' +
          maximumDryDensity.toString(),
      'Optimum moisture content(%) : ' + optimumMoistureContent.toString(),
      'Compaction degree(%) : ' + compactionDegree.toStringAsFixed(4),
      'Required degree of compaction(%) : ' +
          requiredCompactionDegree.toString(),
    ];
    return testDetails;
  }
}
