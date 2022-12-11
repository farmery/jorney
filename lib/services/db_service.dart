// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_print
import 'dart:io';
import 'package:jorney/models/journey.dart';
import 'package:jorney/services/api_service.dart';
import 'package:jorney/services/db_response.dart';
import 'package:sqflite/sqflite.dart';
import '../models/progress.dart';

class DbService {
  late Database db;
  static final DbService _instance = DbService._internal();
  DbService._internal();
  factory DbService({Database? db}) {
    if (db != null) {
      _instance.db = db;
    }
    return _instance;
  }
  final ApiService _apiService = ApiService();

  Future<DbResponse<String>> newJourney(Journey journey) async {
    try {
      final res = await _apiService.startJourney(journey);
      await db.insert('journeys', res.toMap());
      return DbResponse.success('Success');
    } on IOException catch (e) {
      print(e);
      return DbResponse.error('Could not save data');
    } catch (e) {
      print(e);
      return DbResponse.error('An Error Occured');
    }
  }

  Future<DbResponse<String>> updateJourney(String journeyId) async {
    try {
      final res = await _apiService.getJourneyById(journeyId);
      await db.update(
        'journeys',
        res.toMap(),
        where: 'journeyId = ?',
        whereArgs: [journeyId],
      );
      return DbResponse.success('Success');
    } on IOException catch (e) {
      print(e);
      return DbResponse.error('Could not save data');
    } catch (e) {
      print(e);
      return DbResponse.error('An Error Occured');
    }
  }

  Future<DbResponse<List<Journey>>> getJourneyList(String userId) async {
    try {
      final List<Map<String, dynamic>> iJourneys = await db.query('journeys');
      return DbResponse.success(iJourneys.map((e) {
        return Journey.fromMap(e);
      }).toList());
    } catch (e) {
      print(e);
      return DbResponse.error('An Error Occured');
    }
  }

  newProgress(String journeyId, String progressId) async {
    try {
      final newProgress =
          await _apiService.getProgressById(journeyId, progressId);
      await db.insert(
        'progress',
        newProgress.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return DbResponse.success('Success');
    } on IOException catch (e) {
      print(e);
      return DbResponse.error('Could not save data');
    } catch (e) {
      print(e);
      return DbResponse.error('An Error Occured');
    }
  }

  Future<DbResponse<List<Progress>>> getProgressList(String journeyId) async {
    try {
      final List<Map<String, dynamic>> iProgress = await db.query('progress');
      return DbResponse.success(iProgress.map((e) {
        return Progress.fromMap(e);
      }).toList());
    } catch (e) {
      print(e);
      return DbResponse.error('An Error Occured');
    }
  }

  updateProgressWithImage(String progressId, File image) {}
}
