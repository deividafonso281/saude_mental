import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:mockito/mockito.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUserCredential extends Mock implements UserCredential {}

class MockUser extends Mock implements User {}

void main() {
  group('AuthProvider', () {
    late AuthProvider authProvider;
    late MockFirebaseAuth mockFirebaseAuth;
    late StreamController<User?> authStateChangesController;

    setUp(() {
      mockFirebaseAuth = MockFirebaseAuth();
      authStateChangesController = StreamController<User?>();
      when(mockFirebaseAuth.authStateChanges())
          .thenAnswer((_) => authStateChangesController.stream);

      authProvider = AuthProvider();
      authProvider.auth = mockFirebaseAuth;
    });

    tearDown(() {
      authStateChangesController.close();
    });

    test('registerWithEmailAndPassword - success', () async {
      final mockUserCredential = MockUserCredential();
      final mockUser = MockUser();
      when(mockUserCredential.user).thenReturn(mockUser);
      when(mockFirebaseAuth.createUserWithEmailAndPassword(
        email: 'test@example.com',
        password: 'password',
      )).thenAnswer((_) => Future.value(mockUserCredential));

      final result = await authProvider.registerWithEmailAndPassword(
          'test@example.com', 'password');

      expect(result.uid, equals(mockUser.uid));
      expect(authProvider.status, equals(Status.Authenticated));
      verify(mockFirebaseAuth.createUserWithEmailAndPassword(
              email: 'test@example.com', password: 'password'))
          .called(1);
    });

    test('registerWithEmailAndPassword - failure', () async {
      when(mockFirebaseAuth.createUserWithEmailAndPassword(
        email: 'test@example.com',
        password: 'password',
      )).thenThrow(Exception('Registration failed'));

      final result = await authProvider.registerWithEmailAndPassword(
          'test@example.com', 'password');

      expect(result.fullName, equals('Null'));
      expect(result.uid, equals('null'));
      expect(authProvider.status, equals(Status.Unauthenticated));
      verify(mockFirebaseAuth.createUserWithEmailAndPassword(
              email: 'test@example.com', password: 'password'))
          .called(1);
    });

    test('signInWithEmailAndPassword - success', () async {
      when(mockFirebaseAuth.signInWithEmailAndPassword(
        email: 'test@example.com',
        password: 'password',
      )).thenAnswer((_) => Future.value());

      final result = await authProvider.signInWithEmailAndPassword(
          'test@example.com', 'password');

      expect(result, isTrue);
      expect(authProvider.status, equals(Status.Authenticated));
      verify(mockFirebaseAuth.signInWithEmailAndPassword(
              email: 'test@example.com', password: 'password'))
          .called(1);
    });

    test('signInWithEmailAndPassword - failure', () async {
      when(mockFirebaseAuth.signInWithEmailAndPassword(
        email: 'test@example.com',
        password: 'password',
      )).thenThrow(Exception('Sign-in failed'));

      final result = await authProvider.signInWithEmailAndPassword(
          'test@example.com', 'password');

      expect(result, isFalse);
      expect(authProvider.status, equals(Status.Unauthenticated));
      verify(mockFirebaseAuth.signInWithEmailAndPassword(
              email: 'test@example.com', password: 'password'))
          .called(1);
    });

    test('sendPasswordResetEmail', () async {
      await authProvider.sendPasswordResetEmail('test@example.com');

      verify(mockFirebaseAuth.sendPasswordResetEmail(email: 'test@example.com'))
          .called(1);
    });

    test('signOut', () async {
      await authProvider.signOut();

      verify(mockFirebaseAuth.signOut()).called(1);
      expect(authProvider.status, equals(Status.Unauthenticated));
    });
  });
}
