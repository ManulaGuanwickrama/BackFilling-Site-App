import '../project_files/test.dart';

class Layer {
  late Test test;
  late int layerNumber;
  bool isTested = false;
  bool isOkay = false;
  bool pending = false;

  Layer(this.layerNumber);
  void tested() {
    isTested = true;
  }

  Layer.fromMap(Map<String, dynamic> data) {
    layerNumber = data['layerNumber'];
    isTested = data['isTested'];
    isOkay = data['isOkay'];
  }

  void passTest() => isOkay = true;
  void failTest() => isOkay = false;

  Map<String, dynamic> toMap() {
    return {
      'layerNumber': layerNumber,
      'isTested': isTested,
      'isOkay': isOkay,
      'pending': pending,
    };
  }
}
