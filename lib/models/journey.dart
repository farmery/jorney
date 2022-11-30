// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Journey {
  String? userId;
  String? title;
  String? journeyId;
  int? progress;
  JourneyType journeyType;
  Journey({
    this.userId,
    this.title,
    this.journeyId,
    this.progress,
    this.journeyType = JourneyType.monthly,
  });

  Journey copyWith({
    String? userId,
    String? title,
    String? journeyId,
    int? progress,
    JourneyType? journeyType,
  }) {
    return Journey(
      userId: userId ?? this.userId,
      title: title ?? this.title,
      journeyId: journeyId ?? this.journeyId,
      progress: progress ?? this.progress,
      journeyType: journeyType ?? this.journeyType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'title': title,
      'journeyId': journeyId,
      'progress': progress,
      'journeyType': journeyType,
    };
  }

  factory Journey.fromMap(Map<String, dynamic> map) {
    return Journey(
      userId: map['userId'] != null ? map['userId'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      journeyId: map['journeyId'] != null ? map['journeyId'] as String : null,
      progress: map['progress'] != null ? map['progress'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Journey.fromJson(String source) =>
      Journey.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Journey(userId: $userId, title: $title, journeyId: $journeyId, progress: $progress), journeyType: $journeyType';
  }

  @override
  bool operator ==(covariant Journey other) {
    if (identical(this, other)) return true;

    return other.userId == userId &&
        other.title == title &&
        other.journeyId == journeyId &&
        other.journeyType == journeyType &&
        other.progress == progress;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        title.hashCode ^
        journeyId.hashCode ^
        journeyType.hashCode ^
        progress.hashCode;
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
