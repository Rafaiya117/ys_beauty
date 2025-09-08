class SearchModel {
  final String query;
  final List<SearchResult> results;
  final bool isLoading;
  final String? errorMessage;

  const SearchModel({
    required this.query,
    required this.results,
    required this.isLoading,
    this.errorMessage,
  });

  SearchModel copyWith({
    String? query,
    List<SearchResult>? results,
    bool? isLoading,
    String? errorMessage,
  }) {
    return SearchModel(
      query: query ?? this.query,
      results: results ?? this.results,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class SearchResult {
  final String id;
  final String title;
  final String date;
  final String location;
  final String type; // 'event', 'location', 'date'
  final String? description;

  const SearchResult({
    required this.id,
    required this.title,
    required this.date,
    required this.location,
    required this.type,
    this.description,
  });
}
