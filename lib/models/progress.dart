// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Progress {
  String? journeyId;
  String? progressId;
  int progressNo;
  String? imgUrl;
  bool tracked;

  Progress({
    this.journeyId,
    this.progressId,
    this.progressNo = 0,
    this.imgUrl,
    this.tracked = false,
  });

  Progress copyWith({
    String? journeyId,
    String? progressId,
    int? progressNo,
    String? imgUrl,
    bool? tracked,
  }) {
    return Progress(
      journeyId: journeyId ?? this.journeyId,
      progressId: progressId ?? this.progressId,
      progressNo: progressNo ?? this.progressNo,
      imgUrl: imgUrl ?? this.imgUrl,
      tracked: tracked ?? this.tracked,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'journeyId': journeyId,
      'progressId': progressId,
      'progressNo': progressNo,
      'imgUrl': imgUrl,
      'tracked': tracked,
    };
  }

  factory Progress.fromMap(Map<String, dynamic> map) {
    return Progress(
      journeyId: map['journeyId'] != null ? map['journeyId'] as String : null,
      progressId:
          map['progressId'] != null ? map['progressId'] as String : null,
      progressNo: map['progressNo'] as int,
      imgUrl: map['imgUrl'] != null ? map['imgUrl'] as String : null,
      tracked: map['tracked'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Progress.fromJson(String source) =>
      Progress.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Progress(journeyId: $journeyId, progressId: $progressId, progressNo: $progressNo, imgUrl: $imgUrl, tracked: $tracked)';
  }

  @override
  bool operator ==(covariant Progress other) {
    if (identical(this, other)) return true;

    return other.journeyId == journeyId &&
        other.progressId == progressId &&
        other.progressNo == progressNo &&
        other.imgUrl == imgUrl &&
        other.tracked == tracked;
  }

  @override
  int get hashCode {
    return journeyId.hashCode ^
        progressId.hashCode ^
        progressNo.hashCode ^
        imgUrl.hashCode ^
        tracked.hashCode;
  }
}
