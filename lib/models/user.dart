// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  String? userId;
  String? fcmToken;
  String? displayName;
  String? email;
  String? password;
  User({
    this.userId,
    this.fcmToken,
    this.displayName,
    this.email,
    this.password,
  });

  User copyWith({
    String? userId,
    String? fcmToken,
    String? displayName,
    String? email,
    String? password,
  }) {
    return User(
      password: password ?? this.password,
      userId: userId ?? this.userId,
      fcmToken: fcmToken ?? this.fcmToken,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'fcmToken': fcmToken,
      'displayName': displayName,
      'email': email,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['userId'] != null ? map['userId'] as String : null,
      fcmToken: map['fcmToken'] != null ? map['fcmToken'] as String : null,
      displayName:
          map['displayName'] != null ? map['displayName'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(userId: $userId, fcmToken: $fcmToken, displayName: $displayName, email: $email)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.userId == userId &&
        other.fcmToken == fcmToken &&
        other.displayName == displayName &&
        other.email == email;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        fcmToken.hashCode ^
        displayName.hashCode ^
        email.hashCode;
  }
}
