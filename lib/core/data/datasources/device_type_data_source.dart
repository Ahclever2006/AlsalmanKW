import 'dart:io';

abstract class DeviceTypeDataSource {
  String getDeviceType();
}

class DeviceTypeDataSourceImpl implements DeviceTypeDataSource {
  @override
  String getDeviceType() {
    final deviceType = Platform.isIOS ? 'IOS' : 'Android';
    return deviceType;
  }
}
