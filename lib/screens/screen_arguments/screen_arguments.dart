import '../register_screen.dart';

class CreateProjectScreenArguments {
  String uid;

  CreateProjectScreenArguments(this.uid);
}

class ProjectScreenArguments {
  String character;

  ProjectScreenArguments(this.character);
}

class SectionsScreenArguments {
  String character;
  String projectID;
  SectionsScreenArguments(this.character, this.projectID);
}

class LayersScreenArguments {
  String projectID;
  int sectionID;

  LayersScreenArguments(this.projectID, this.sectionID);
}

class TestEnterScreenArguments {
  String projectID;
  int sectionID;
  int layerID;

  TestEnterScreenArguments(this.projectID, this.sectionID, this.layerID);
}

class UserScreenArguments {
  String firstName;
  String lastName;
  String email;

  UserScreenArguments(this.lastName, this.firstName, this.email);
}
