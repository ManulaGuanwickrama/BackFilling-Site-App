import '../sevices/database.dart';
import '../models/project_files/project.dart';

class CreateProjectDatabase {
  final String uid;
  final Project project;
  late final DatabaseService projectDatabase;

  CreateProjectDatabase(this.uid, this.project) {
    projectDatabase = DatabaseService('projects');
  }

  void createProject() async {
    Map<String, dynamic> projectData = project.toMap();
    projectData['creatorID'] = uid;
    String projectID = await projectDatabase.addData(projectData);
    //adding sections
    for (var section in project.sections) {
      projectDatabase.addCollectionToDocument(
        section.toMap(),
        projectID,
        'sections',
        section.sectionId.toString(),
      );
      for (var layer in section.layers) {
        projectDatabase.addCollectionInSubCollection(
          layer.toMap(),
          projectID,
          'sections',
          section.sectionId.toString(),
          'layers',
          layer.layerNumber.toString(),
        );
      }
    }
  }
}
