import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

abstract class GoogleAuthRemoteDataSource {
  Future<UserCredential> signIn();
  Future<void> signOut();
}

@LazySingleton(as: GoogleAuthRemoteDataSource)
class GoogleAuthRemoteDataSourceImpl implements GoogleAuthRemoteDataSource {
  final GoogleSignIn _google;
  final FirebaseAuth _auth;

  GoogleAuthRemoteDataSourceImpl(this._google, this._auth);

  @override
  Future<UserCredential> signIn() async {
    // 1️⃣ trigger Google sign‑in UI
    final googleUser = await _google.authenticate();

    // 2️⃣ obtain OAuth tokens
    final googleAuth = googleUser.authentication;

    // 3️⃣ build Firebase credential
    final credential = GoogleAuthProvider.credential(
      accessToken: '12312',
      idToken: googleAuth.idToken,
    );

    // 4️⃣ sign‑in to Firebase
    return _auth.signInWithCredential(credential);
  }

  @override
  Future<void> signOut() async {
    await _google.signOut();
    await _auth.signOut();
  }
}
