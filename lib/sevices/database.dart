import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  static final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  String uid = '';
  String path;

  //constructor
  DatabaseService(this.path);

  Future<String> addData(Map<String, dynamic> data) async {
    //fireStore.collection(path).add(data);
    DocumentReference docRef = await fireStore.collection(path).add(data);
    DocumentSnapshot docSnap = await docRef.get();
    return docSnap.reference.id;
  }

  Future<void> setData(String docID, Map<String, dynamic> data) async {
    await fireStore.collection(path).doc(docID).set(data);
  }

  String addCollectionToDocument(
    Map<String, dynamic> data,
    String documentID,
    String collectionName,
    String currentDocID,
  ) {
    fireStore
        .collection(path)
        .doc(documentID)
        .collection(collectionName)
        .doc(currentDocID)
        .set(data);
    return currentDocID;
  }

  String addCollectionInSubCollection(
    Map<String, dynamic> data,
    String documentID,
    String collectionName,
    String secondDocumentID,
    String subCollection,
    String currentDocID,
  ) {
    fireStore
        .collection(path)
        .doc(documentID)
        .collection(collectionName)
        .doc(secondDocumentID)
        .collection(subCollection)
        .doc(currentDocID)
        .set(data);
    return currentDocID;
  }

  /*Functions for test*/
  void addTest(
    Map<String, dynamic> data,
    String projectID,
    String sectionID,
    String layerID,
  ) {
    fireStore
        .collection(path)
        .doc(projectID)
        .collection('sections')
        .doc(sectionID)
        .collection('layers')
        .doc(layerID)
        .collection('test')
        .doc('currentTest')
        .set(data);
    fireStore
        .collection('requests')
        .doc(projectID + sectionID + layerID)
        .delete();
  }

  Future<void> testPass(
    String projectID,
    String sectionID,
    String layerID,
  ) async {
    await fireStore
        .collection(path)
        .doc(projectID)
        .collection('sections')
        .doc(sectionID)
        .collection('layers')
        .doc(layerID)
        .update(<String, dynamic>{
      'layerNumber': int.parse(layerID),
      'isTested': true,
      'isOkay': true,
    });
    int numberOfCompleteLayers;
    int numOfLayers;

    //getting current number of completed layers
    numberOfCompleteLayers = await fireStore
        .collection(path)
        .doc(projectID)
        .collection('sections')
        .doc(sectionID)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      return documentSnapshot.get('numberOfCompleteLayers');
    });
    numberOfCompleteLayers++;
    await fireStore
        .collection(path)
        .doc(projectID)
        .collection('sections')
        .doc(sectionID)
        .update({'numberOfCompleteLayers': numberOfCompleteLayers});

    numOfLayers = await fireStore
        .collection(path)
        .doc(projectID)
        .collection('sections')
        .doc(sectionID)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      return documentSnapshot.get('numOfLayers');
    });

    if (numberOfCompleteLayers == numOfLayers) {
      int numberOfCompleteSections;
      numberOfCompleteSections = await fireStore
          .collection(path)
          .doc(projectID)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        return documentSnapshot.get('numberOfCompleteSections');
      });

      numberOfCompleteSections++;

      await fireStore
          .collection(path)
          .doc(projectID)
          .update({'numberOfCompleteSections': numberOfCompleteSections});
    }
  }

  void testFail(
    String projectID,
    String sectionID,
    String layerID,
  ) {
    fireStore
        .collection(path)
        .doc(projectID)
        .collection('sections')
        .doc(sectionID)
        .collection('layers')
        .doc(layerID)
        .update(<String, dynamic>{
      'layerNumber': int.parse(layerID),
      'isTested': true,
      'isOkay': false,
    });
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getTestDetails(
    String projectID,
    String sectionID,
    String layerID,
  ) async {
    return await fireStore
        .collection(path)
        .doc(projectID)
        .collection('sections')
        .doc(sectionID)
        .collection('layers')
        .doc(layerID)
        .collection('test')
        .doc('currentTest')
        .get();
  }

  String addCollectionInSubCollectionOfSubCollection(
    Map<String, dynamic> data,
    String documentID,
    String collectionName,
    String secondDocumentID,
    String secondCollectionName,
    String thirdDocumentID,
    String subCollectionName,
    String currentDocID,
  ) {
    fireStore
        .collection(path)
        .doc(documentID)
        .collection(collectionName)
        .doc(secondDocumentID)
        .collection(thirdDocumentID)
        .doc(thirdDocumentID)
        .collection(subCollectionName)
        .doc(currentDocID)
        .set(data);

    return currentDocID;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getData(String orderBy) {
    return fireStore
        .collection(path)
        .orderBy(orderBy, descending: false)
        .snapshots();
  }

  /*Stream<QuerySnapshot<Map<String, dynamic>>> snapshots() {
    return fireStore.collection(path).snapshots();
  }*/

  Stream<QuerySnapshot<Map<String, dynamic>>> getDataFromSubCollection(
    String docID,
    String collectionPath,
    String orderBy,
  ) {
    return fireStore
        .collection(path)
        .doc(docID)
        .collection(collectionPath)
        .orderBy(orderBy, descending: false)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>
      getDataFromHierarchyOfTwoSubCollections(
    String firstDocID,
    String firstCollectionPath,
    String secondDocID,
    String secondCollectionPath,
    String orderBy,
  ) {
    return fireStore
        .collection(path)
        .doc(firstDocID)
        .collection(firstCollectionPath)
        .doc(secondDocID)
        .collection(secondCollectionPath)
        .orderBy(orderBy, descending: false)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>
      getDataFromHierarchyOfThreeSubCollections(
    String firstDocID,
    String firstCollectionPath,
    String secondDocID,
    String secondCollectionPath,
    String thirdDocID,
    String thirdCollectionPath,
    String orderBy,
  ) {
    return fireStore
        .collection(path)
        .doc(firstDocID)
        .collection(firstCollectionPath)
        .doc(secondDocID)
        .collection(secondCollectionPath)
        .doc(thirdDocID)
        .collection(thirdCollectionPath)
        .orderBy(orderBy, descending: false)
        .snapshots();
  }

  /*Future<List<Map<String, dynamic>>?> getData() async {
    final snapshots = await firestore.collection(path).get();
    List<Map<String, dynamic>>? data;
    for (var snapshot in snapshots.docs) {
      data!.add(snapshot.data());
    }
    return data;
  }*/

  /*
  * For Layers page
  * To identify the pending layers separately
  */
  Stream<QuerySnapshot<Map<String, dynamic>>> getPendingLayers(
      String projectID, String sectionID) {
    return fireStore
        .collection(path)
        .where('projectID', isEqualTo: projectID)
        .where('sectionID', isEqualTo: sectionID)
        .snapshots();
  }

  Future<void>? updatePendingState(
    bool isPending,
    String projectID,
    String sectionID,
    String layerID,
  ) {
    try {
      return fireStore
          .collection(path)
          .doc(projectID)
          .collection('sections')
          .doc(sectionID)
          .collection('layers')
          .doc(layerID)
          .update(<String, dynamic>{
        'layerNumber': int.parse(layerID),
        'isTested': false,
        'isOkay': false,
        'pending': isPending,
      });
    } catch (e) {
      print('Error in updating project pending');
      print('In services/database.dart');
      print(e);
    }
  }

  Future<String> getProjectName(String projectID) async {
    return await fireStore
        .collection(path)
        .doc(projectID)
        .get()
        .then((value) => value.data()!['name'].toString());
  }

  int getNumberKeyValuePairs() {
    return fireStore.collection(path).parameters.length;
  }

  /*Future<int> getNumberOfLayersFinished(
      String projectID, String sectionID) async {
    return await fireStore
        .collection(path)
        .doc(projectID)
        .collection('sections')
        .doc(sectionID)
        .collection('layers')
        .where('isOkay', isEqualTo: true)
        .snapshots()
        .length;
  }*/

  Future<QuerySnapshot<Map<String, dynamic>>> getProgress(
    String docID,
    String collectionPath,
  ) async {
    return await fireStore
        .collection(path)
        .doc(docID)
        .collection(collectionPath)
        .get();
  }
}
