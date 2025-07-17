import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

abstract class GoogleAuthRemoteDataSource {
  Future<GoogleSignInAccount?> signIn();
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
  Future<void> signOut() async {
    await _google.signOut();
  }
}
