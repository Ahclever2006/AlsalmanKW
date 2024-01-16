import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '/core/enums/provider_enum.dart';
import '../../features/auth/data/models/user.dart';

class UserAdapter {
  Future<User> adapt(user) {
    if (user is GoogleSignInAccount)
      return _adaptGoogleAccount(user);
    else
      return _adaptAppleAccount(user);
  }

  Future<User> _adaptGoogleAccount(GoogleSignInAccount user) async {
    final userNameList = user.displayName!.split(' ');
    final firstName = userNameList.first;
    final lastName = userNameList.last;

    final auth = await user.authentication;
    final idToken = auth.idToken;

    return User(
      firstName: firstName,
      lastName: lastName,
      email: user.email,
      token: idToken,
      provider: ProviderEnum.Google.index,
    );
  }

  Future<User> _adaptAppleAccount(AuthorizationCredentialAppleID user) async {
    final firstName = user.givenName;
    final lastName = user.familyName;
    final email = user.email;
    final idToken = user.identityToken;
    return User(
      firstName: firstName ?? '',
      lastName: lastName ?? '',
      email: email ?? '',
      token: idToken,
      provider: ProviderEnum.Apple.index,
    );
  }
}
