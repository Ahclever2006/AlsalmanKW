import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '/core/exceptions/social_media_login_canceled_exception.dart';
import '../../../api_end_point.dart';
import '../../../features/auth/data/models/user.dart';
import '../../adapters/user_adapter.dart';

abstract class ExternalLoginDataSource {
  Future<User> login();
  Future<void> logOut();
}

class GoogleExternalLoginDataSourceImpl implements ExternalLoginDataSource {
  final _googleSignIn = GoogleSignIn(scopes: [
    'email',
  ]);

  @override
  Future<User> login() async {
    if (await _googleSignIn.isSignedIn()) await logOut();
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null)
      throw SocialLoginCanceledException("User didn't login");
    final userAdapter = UserAdapter();
    final user = await userAdapter.adapt(googleUser);
    return user;
  }

  @override
  Future<void> logOut() async {
    if (await _googleSignIn.isSignedIn()) _googleSignIn.signOut();
  }
}

class AppleExternalLoginDataSourceImpl implements ExternalLoginDataSource {
  @override
  Future<User> login() async {
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      webAuthenticationOptions: WebAuthenticationOptions(
        clientId: 'com.baramjk.tis',
        redirectUri: Uri.parse(ApiEndPoint.apple_redirect_url),
      ),
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    final userAdapter = UserAdapter();
    final user = await userAdapter.adapt(appleCredential);
    return user;
  }

  @override
  Future<void> logOut() {
    //Apple not enabled logout
    throw UnimplementedError();
  }
}
