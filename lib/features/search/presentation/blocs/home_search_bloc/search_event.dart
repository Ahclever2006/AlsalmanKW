part of 'search_bloc.dart';

enum SearchEventStatus { initial, search, loadMore }

extension on SearchEvent {
  // bool get isInitial => status == SearchEventStatus.initial;
  bool get isSearch => status == SearchEventStatus.search;
  bool get isLoadMore => status == SearchEventStatus.loadMore;
}

@immutable
class SearchEvent {
  final SearchEventStatus status;
  final String? searchText;

  const SearchEvent({
    required this.status,
    this.searchText,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other.runtimeType == runtimeType &&
        (other as SearchEvent).status == status &&
        other.searchText == searchText;
  }

  @override
  int get hashCode => status.hashCode ^ searchText.hashCode;

  SearchEvent copyWith({
    SearchEventStatus? status,
    String? searchText,
  }) {
    return SearchEvent(
      status: status ?? this.status,
      searchText: searchText ?? this.searchText,
    );
  }
}
