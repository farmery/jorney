// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Journey {
  String? userId;
  String? title;
  String? journeyId;
  int? level;
  JourneyType journeyType;
  DateTime? createdAt;
  DateTime? startDate;
  Journey({
    this.userId,
    this.title,
    this.journeyId,
    this.level,
    this.journeyType = JourneyType.monthly,
    this.createdAt,
    this.startDate,
  });

  Journey copyWith({
    String? userId,
    String? title,
    String? journeyId,
    int? level,
    JourneyType? journeyType,
    DateTime? createdAt,
    DateTime? startDate,
  }) {
    return Journey(
      userId: userId ?? this.userId,
      title: title ?? this.title,
      journeyId: journeyId ?? this.journeyId,
      level: level ?? this.level,
      journeyType: journeyType ?? this.journeyType,
      createdAt: createdAt ?? this.createdAt,
      startDate: startDate ?? this.startDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'title': title,
      'journeyId': journeyId,
      'level': level,
      'journeyType': journeyType.name,
      'startDate': startDate,
      'createdAt': createdAt,
    };
  }

  factory Journey.fromMap(Map<String, dynamic> map) {
    return Journey(
      userId: map['userId'] != null ? map['userId'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      journeyId: map['journeyId'] != null ? map['journeyId'] as String : null,
      level: map['level'] != null ? map['level'] as int : null,
      journeyType: getJourneyType(map['journeyType']),
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      startDate: (map['startDate'] as Timestamp).toDate(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Journey.fromJson(String source) =>
      Journey.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Journey(userId: $userId, title: $title, journeyId: $journeyId, level: $level), journeyType: $journeyType';
  }

  @override
  bool operator ==(covariant Journey other) {
    if (identical(this, other)) return true;

    return other.userId == userId &&
        other.title == title &&
        other.journeyId == journeyId &&
        other.journeyType == journeyType &&
        other.createdAt == createdAt &&
        other.level == level;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        title.hashCode ^
        journeyId.hashCode ^
        journeyType.hashCode ^
        level.hashCode;
  }
}

enum JourneyType {
  daily,
  weekly,
  monthly;

  @override
  String toString() {
    switch (name) {
      case 'daily':
        return 'Day';
      case 'weekly':
        return 'Week';
      case 'monthly':
        return 'Month';
    }
    return '';
  }
}

JourneyType getJourneyType(String? val) {
  switch (val) {
    case 'daily':
      return JourneyType.daily;
    case 'weekly':
      return JourneyType.weekly;
    case 'monthly':
      return JourneyType.monthly;
  }
  return JourneyType.weekly;
}
