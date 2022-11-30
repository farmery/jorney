// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Progress {
  String journeyId;
  int progressNo;
  List<String> imageUrl;
  Progress({
    required this.journeyId,
    required this.progressNo,
    required this.imageUrl,
  });

  Progress copyWith({
    String? journeyId,
    int? progressNo,
    List<String>? imageUrl,
  }) {
    return Progress(
      journeyId: journeyId ?? this.journeyId,
      progressNo: progressNo ?? this.progressNo,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'journeyId': journeyId,
      'progressNo': progressNo,
      'imageUrl': imageUrl,
    };
  }

  factory Progress.fromMap(Map<String, dynamic> map) {
    return Progress(
        journeyId: map['journeyId'] as String,
        progressNo: map['progressNo'] as int,
        imageUrl: List<String>.from(
          (map['imageUrl'] as List<String>),
        ));
  }

  String toJson() => json.encode(toMap());

  factory Progress.fromJson(String source) =>
      Progress.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Progress(journeyId: $journeyId, progressNo: $progressNo, imageUrl: $imageUrl)';

  @override
  bool operator ==(covariant Progress other) {
    if (identical(this, other)) return true;

    return other.journeyId == journeyId &&
        other.progressNo == progressNo &&
        listEquals(other.imageUrl, imageUrl);
  }

  @override
  int get hashCode =>
      journeyId.hashCode ^ progressNo.hashCode ^ imageUrl.hashCode;
}
