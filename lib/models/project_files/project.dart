import 'package:flutter/material.dart';
import 'distance.dart';
import '../project_files/section.dart';

const int sectionLength = 250; //legth of a section

class Project {
  /*Project.getProject(
      {required this.name,
      required this.length,
      required this.depth,
      required this.sections});*/
  late String name;
  late Distance length;
  late double depth;
  late int numberOfSections;
  int numberOfCompleteSections = 0;
  List<Section> sections = [];

  Project({required this.name, required this.length, required this.depth}) {
    createSections();
  }

  Project.getProject(Map<String, dynamic> projectData, this.sections) {
    name = projectData['name'];
    length.meters = projectData['length_meters'];
    length.kilometers = projectData['length_killometers'];
    depth = projectData['depth'];
  }

  void createSections() {
    int total = length.kilometers * 1000 + length.meters;
    Distance start = Distance(meters: 0, kilometers: 0);
    Distance end = Distance(meters: 200, kilometers: 0);
    int sectionID = 1;
    while (total > sectionLength) {
      sections.add(Section(
          sectionId: sectionID, start: start, finish: end, depth: depth));
      start = start.add(sectionLength);
      end = end.add(sectionLength);
      total = total - sectionLength;
      sectionID++;
    }
    numberOfSections = sectionID;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'length_meters': length.meters,
      'length_killometers': length.kilometers,
      'depth': depth,
      'numberOfSections': numberOfSections,
      'numberOfCompleteSections': numberOfCompleteSections,
    };
  }
}
