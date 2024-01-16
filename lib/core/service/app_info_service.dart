import 'package:package_info_plus/package_info_plus.dart';

abstract class AppInfoService {
  Future<AppInfo> init();
}

class AppInfoServiceImpl implements AppInfoService {
  @override
  Future<AppInfo> init() async {
    final packageInfo = await PackageInfo.fromPlatform();

    return AppInfo(
      appName: packageInfo.appName,
      packageName: packageInfo.packageName,
      version: packageInfo.version,
      buildNumber: packageInfo.buildNumber,
    );
  }
}

class AppInfo {
  final String appName;
  final String packageName;
  final String version;
  final String buildNumber;

  AppInfo({
    this.appName = 'appName',
    this.packageName = 'packageName',
    this.version = 'version',
    this.buildNumber = 'buildNumber',
  });
}
