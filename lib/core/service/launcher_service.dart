import 'package:url_launcher/url_launcher.dart';

import '../exceptions/launcher_exception.dart';

abstract class LauncherService {
  Future<void> callPhone(String phoneNumber);
  Future<void> openWhatsappChat({String? phoneNumber});
  Future<void> openWebsite(String url);
  Future<void> openGoogleMaps(String url);
  Future<void> sendEmail(String email, [String? emailSubject, String? message]);
}

class LauncherServiceImpl extends LauncherService {
  @override
  Future<void> callPhone(String phoneNumber) async {
    final uri = Uri.parse('tel:$phoneNumber');
    final result = await canLaunchUrl(uri);
    if (result)
      await launchUrl(uri);
    else
      throw LauncherException();
  }

  @override
  Future<void> openWebsite(String url) async {
    final uri = Uri.parse(url.trim());

    final result = await canLaunchUrl(uri);
    if (result)
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    else
      throw LauncherException();
  }

  @override
  Future<void> openWhatsappChat({String? phoneNumber}) async {
    var url = 'whatsapp://send';

    final linkAttributesList = <String>[];
    if (phoneNumber != null) linkAttributesList.add('phone=$phoneNumber');

    if (linkAttributesList.isNotEmpty)
      url = '$url?${linkAttributesList.join('&')}';

    final uri = Uri.parse(url);

    final result = await canLaunchUrl(uri);
    if (result)
      await launchUrl(uri);
    else
      throw LauncherException();
  }

  @override
  Future<void> sendEmail(
    String email, [
    String? emailSubject,
    String? message,
  ]) async {
    final uri = Uri.parse('mailto:$email');

    final result = await canLaunchUrl(uri);
    if (result)
      await launchUrl(uri);
    else
      throw LauncherException();
  }

  @override
  Future<void> openGoogleMaps(String url) async {
    final uri = Uri.parse(url);

    final result = await canLaunchUrl(uri);
    if (result)
      await launchUrl(uri);
    else
      throw LauncherException();
  }
}
