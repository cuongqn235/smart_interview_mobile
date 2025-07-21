import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

abstract class GoogleAuthRemoteDataSource {
  Future<GoogleSignInAccount?> signIn();
  Future<bool> signInWithServerClientId();
  Future<void> signOut();
}

@Singleton(as: GoogleAuthRemoteDataSource)
class GoogleAuthRemoteDataSourceImpl implements GoogleAuthRemoteDataSource {
  final GoogleSignIn _google;

  GoogleAuthRemoteDataSourceImpl(this._google);

  @override
  Future<GoogleSignInAccount?> signIn() async {
    try {
      final googleUser = await _google.authenticate();
      return googleUser;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> signInWithServerClientId() async {
    final isIos = Platform.isIOS;
    if (isIos) {
      return true;
    }
    await _google.initialize(
      serverClientId: dotenv.env['SERVER_CLIENT_ID'] ?? '',
    );
    return true;
  }

  @override
  Future<void> signOut() async {
    await _google.signOut();
  }
}
