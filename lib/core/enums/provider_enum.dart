import '/core/enums/index_name.dart';

class ProviderEnum extends IndexName {
  const ProviderEnum._(index, name) : super(index, name);

  static const Facebook = ProviderEnum._(1, 'Facebook');
  static const Google = ProviderEnum._(2, 'Google');
  static const Apple = ProviderEnum._(3, 'Apple');

  static List<ProviderEnum> get values => [Facebook, Google, Apple];
}
