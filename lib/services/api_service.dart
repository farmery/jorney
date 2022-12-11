import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jorney/models/progress.dart';
import '../models/journey.dart';
import '../models/user.dart';

class ApiService {
  final _db = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get journeyCollection =>
      _db.collection('journeys');
  CollectionReference<Map<String, dynamic>> get userCollection =>
      _db.collection('users');

  Future<User> newUser(User user) async {
    try {
      await userCollection.doc(user.userId).set(user.toMap());
      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future<User> updatedEmail(User user) async {
    try {
      await userCollection.doc(user.userId).update({'email': user.email});
      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future<Journey> startJourney(Journey journey) async {
    try {
      return journey;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Journey>> getJourneys(String userId) async {
    try {
      final snapshot =
          await journeyCollection.where(userId, isEqualTo: userId).get();
      final journeys =
          snapshot.docs.map((e) => Journey.fromFirebase(e.data())).toList();
      return journeys;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Progress>> getProgressList(String journeyId) async {
    try {
      final progressRef =
          journeyCollection.doc(journeyId).collection('progress');
      final snapshot = await progressRef.get();

      final progressList = snapshot.docs.reversed
          .map((e) => Progress.fromMap(e.data()))
          .toList();
      return progressList;
    } catch (e) {
      rethrow;
    }
  }

  Future<Progress> getProgressById(String journeyId, String progressId) async {
    try {
      final progressRef = journeyCollection
          .doc(journeyId)
          .collection('progress')
          .doc(progressId);
      final snapshot = await progressRef.get();

      final progress = snapshot.data();
      return Progress.fromMap(progress!);
    } catch (e) {
      rethrow;
    }
  }

  Future<Journey> getJourneyById(String journeyId) async {
    try {
      final progressRef = journeyCollection.doc(journeyId);
      final snapshot = await progressRef.get();
      final journey = snapshot.data();
      return Journey.fromMap(journey!);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> updateProgress(Progress progress) async {
    try {
      final progressRef = journeyCollection
          .doc(progress.journeyId)
          .collection('progress')
          .doc(progress.progressId);
      progressRef.update({'imageUrl': progress.imgUrl, 'tracked': true});
      return 'Success';
    } catch (e) {
      rethrow;
    }
  }
}
