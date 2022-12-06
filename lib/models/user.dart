import 'dart:convert';

class User {
  String? userId;
  String? fcmToken;
  String? displayName;
  User({
    this.userId,
    this.fcmToken,
    this.displayName,
  });

  User copyWith({
    String? userId,
    String? fcmToken,
    String? displayName,
  }) {
    return User(
      userId: userId ?? this.userId,
      fcmToken: fcmToken ?? this.fcmToken,
      displayName: displayName ?? this.displayName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'fcmToken': fcmToken,
      'displayName': displayName,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['userId'] != null ? map['userId'] as String : null,
      fcmToken: map['fcmToken'] != null ? map['fcmToken'] as String : null,
      displayName:
          map['displayName'] != null ? map['displayName'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'User(userId: $userId, fcmToken: $fcmToken, displayName: $displayName)';

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.userId == userId &&
        other.fcmToken == fcmToken &&
        other.displayName == displayName;
  }

  @override
  int get hashCode =>
      userId.hashCode ^ fcmToken.hashCode ^ displayName.hashCode;
}
