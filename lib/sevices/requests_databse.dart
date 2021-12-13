import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_try_backfilling/sevices/database.dart';

class RequestsDatabase {
  static final DatabaseService requestDatabase = DatabaseService('requests');
  static final DatabaseService projectsDatabase = DatabaseService('projects');

  late final String projectID;
  late final String sectionID;
  late final String layerID;

  RequestsDatabase.withData(this.projectID, this.sectionID, this.layerID);
  RequestsDatabase();

  Future<void> putRequest() async {
    String projectName = await projectsDatabase.getProjectName(projectID);
    await projectsDatabase.updatePendingState(
        true, projectID, sectionID, layerID);
    await requestDatabase.setData(projectID + sectionID + layerID, {
      'projectID': projectID,
      'projectName': projectName,
      'sectionID': sectionID,
      'layerID': layerID,
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getRequests() {
    return requestDatabase.getData('projectName');
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getPendingLayers() {
    return requestDatabase.getPendingLayers(projectID, sectionID);
  }

  int getNumberOfRequests() {
    return (requestDatabase.getNumberKeyValuePairs() / 4).floor();
  }
}
