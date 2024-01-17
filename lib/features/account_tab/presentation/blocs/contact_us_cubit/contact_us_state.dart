part of 'contact_us_cubit.dart';

enum ContactUsStateStatus { initial, loading, loaded, error }

extension ContactUsStateX on ContactUsState {
  bool get isInitial => status == ContactUsStateStatus.initial;
  bool get isLoading => status == ContactUsStateStatus.loading;
  bool get isLoaded => status == ContactUsStateStatus.loaded;
  bool get isError => status == ContactUsStateStatus.error;
}

@immutable
class ContactUsState {
  final ContactUsStateStatus status;
  final String? errorMessage;
  const ContactUsState({
    this.status = ContactUsStateStatus.initial,
    this.errorMessage,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other.runtimeType == runtimeType &&
        (other as ContactUsState).status == status &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode => status.hashCode ^ errorMessage.hashCode;

  ContactUsState copyWith({
    ContactUsStateStatus? status,
    String? errorMessage,
  }) {
    return ContactUsState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
