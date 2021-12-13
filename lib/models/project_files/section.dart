import 'package:first_try_backfilling/models/project_files/layer.dart';
import 'package:first_try_backfilling/models/project_files/distance.dart';

class Section {
  late final int sectionId;
  late final Distance start;
  late final Distance finish;
  late final double depth; //in meters
  int numOfLayers = 0;
  int numberOfCompleteLayers = 0;
  List<Layer> layers = [];

  Section(
      {required this.sectionId,
      required this.start,
      required this.finish,
      required this.depth}) {
    numOfLayers = depth * 1000 ~/ 250;
    createLayers();
  }

  void createLayers() {
    for (int i = 1; i <= numOfLayers; i++) {
      layers.add(Layer(i));
    }
  }

  Section.getFromMap(Map<String, dynamic> data, this.layers) {
    sectionId = data['sectionID'];
    start.fromMeters(data['start']);
    finish.fromMeters(data['finish']);
    depth = data['depth'];
    numOfLayers = data['numOfLayers'];
    numberOfCompleteLayers = data['numberOfCompleteLayers'];
  }

  Map<String, dynamic> toMap() {
    return {
      'sectionID': sectionId,
      'start': start.toMeters(),
      'finish': finish.toMeters(),
      'depth': depth,
      'numOfLayers': numOfLayers,
      'numberOfCompleteLayers': numberOfCompleteLayers,
    };
  }

  getFromMap(Map<String, dynamic> data) {
    start.fromMeters(data['start']);
    finish.fromMeters(data['finish']);
    depth = data['depth'];
    numOfLayers = data['numOfLayers'];
  }
}
