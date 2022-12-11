import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jorney/models/user.dart' as user_model;
import 'package:jorney/services/api_service.dart';
import 'package:jorney/services/db_response.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _apiService = ApiService();

  Stream<user_model.User?> getSignedInUser() {
    return _auth.authStateChanges().asBroadcastStream().map(
          (event) => user_model.User(
            displayName: event!.displayName,
            email: event.email,
            userId: event.uid,
          ),
        );
  }

  Future<DbResponse<user_model.User>> createAccount(
      user_model.User user) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: user.email!,
        password: user.password!,
      );
      final fcmToken = await FirebaseMessaging.instance.getToken();
      final loggedInUser = user_model.User(
        email: credential.user?.email,
        displayName: credential.user?.displayName,
        fcmToken: fcmToken,
        userId: credential.user?.uid,
      );
      await _apiService.newUser(loggedInUser);
      return DbResponse.success(loggedInUser);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return DbResponse.error('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return DbResponse.error('The account already exists for that email.');
      }
      return DbResponse.error(e.message ?? 'An Error Occured');
    } catch (e) {
      return DbResponse.error('An Error Occured');
    }
  }

  Future<DbResponse<user_model.User>> signInUser(user_model.User user) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: user.email!,
        password: user.password!,
      );
      _auth.currentUser?.updateDisplayName(user.displayName);
      final fcmToken = await FirebaseMessaging.instance.getToken();
      final loggedInUser = user_model.User(
        email: credential.user?.email,
        displayName: credential.user?.displayName,
        fcmToken: fcmToken,
      );
      return DbResponse.success(loggedInUser);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        return DbResponse.error('Password or Email incorrect');
      } else if (e.code == 'user-disabled') {
        return DbResponse.error('User has been disabled');
      }
      return DbResponse.error(e.message ?? 'An Error Occured');
    } catch (e) {
      return DbResponse.error('An Error Occured');
    }
  }

  Future<DbResponse> updateUserEmail(String email) async {
    try {
      final userId = _auth.currentUser!.uid;
      await _auth.currentUser!.updateEmail(email);
      await _apiService.updatedEmail(
        user_model.User(userId: userId, email: email),
      );
      return DbResponse.success('Email successfully updated');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        return DbResponse.error(
          'Please logout and sign in again to perform this action',
        );
      }
      return DbResponse.error(e.message!);
    } catch (e) {
      print(e);
      return DbResponse.error('Could not update email');
    }
  }

  Future<DbResponse> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return DbResponse.success('Email successfully updated');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'auth/invalid-email') {
        return DbResponse.error('Invalid Email');
      } else if (e.code == 'auth/user-not-found') {
        return DbResponse.error('User does not exist');
      }
      return DbResponse.error(e.message ?? 'An Error Occured');
    } catch (e) {
      return DbResponse.error('An Error Occured');
    }
  }

  Future<DbResponse> changePassword(String newPassword) async {
    try {
      await _auth.currentUser!.updatePassword(newPassword);
      return DbResponse.success('Password successfully changed');
    } catch (e) {
      print(e);
      return DbResponse.error('Could not change password');
    }
  }

  Future<DbResponse<String>> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return DbResponse.success('Signed out successfully');
    } catch (e) {
      print(e);
      return DbResponse.error('Could not sign out');
    }
  }
}

final authStateChanges = StreamProvider.autoDispose<user_model.User?>(
  (ref) {
    return FirebaseAuth.instance.authStateChanges().asBroadcastStream().map(
      (event) {
        if (event != null) {
          return user_model.User(
            displayName: event.displayName,
            email: event.email,
            userId: event.uid,
          );
        }
        return null;
      },
    );
  },
);
