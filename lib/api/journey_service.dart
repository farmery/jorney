import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jorney/api/api_response.dart';
import 'package:jorney/models/progress.dart';

import '../models/journey.dart';

class JourneyService {
  final db = FirebaseFirestore.instance;
  CollectionReference<Map<String, dynamic>> get journeyCollection =>
      db.collection('journeys');

  Future<ApiResponse<String>> startJourney(Journey journey) async {
    try {
      final docRef = await journeyCollection.add(journey.toMap());
      return ApiResponse.success(docRef.id);
    } catch (e) {
      print(e);
      return ApiResponse.error('An Error Occured');
    }
  }

  Future<ApiResponse<List<Journey>>> getJourneys() async {
    try {
      final snapshot = await journeyCollection.get();
      final journeys =
          snapshot.docs.map((e) => Journey.fromMap(e.data())).toList();
      return ApiResponse.success(journeys);
    } catch (e) {
      print(e);
      return ApiResponse.error('An Error Occured');
    }
  }

  Future<ApiResponse<List<Progress>>> getProgress(String journeyId) async {
    try {
      final progressRef =
          journeyCollection.doc(journeyId).collection('progress');
      final snapshot = await progressRef.get();

      final progress = snapshot.docs.reversed
          .map((e) => Progress.fromMap(e.data()))
          .toList();
      return ApiResponse.success(progress);
    } catch (e) {
      print(e);
      return ApiResponse.error('An Error Occured');
    }
  }
}
