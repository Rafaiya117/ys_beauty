import 'package:flutter/material.dart';
import '../model/search_model.dart';
import '../repository/search_repository.dart';

class SearchViewModel extends ChangeNotifier {
  final SearchRepository _repository = SearchRepository();
  
  SearchModel _searchModel = const SearchModel(
    query: '',
    results: [],
    isLoading: false,
  );
  
  final TextEditingController _searchController = TextEditingController();

  // Getters
  SearchModel get searchModel => _searchModel;
  String get query => _searchModel.query;
  List<SearchResult> get results => _searchModel.results;
  bool get isLoading => _searchModel.isLoading;
  String? get errorMessage => _searchModel.errorMessage;
  TextEditingController get searchController => _searchController;

  // Search methods
  Future<void> search(String query) async {
    if (query.trim().isEmpty) {
      _searchModel = _searchModel.copyWith(
        query: '',
        results: [],
        isLoading: false,
        errorMessage: null,
      );
      notifyListeners();
      return;
    }

    _searchModel = _searchModel.copyWith(
      query: query,
      isLoading: true,
      errorMessage: null,
    );
    notifyListeners();

    try {
      final results = await _repository.search(query);
      _searchModel = _searchModel.copyWith(
        results: results,
        isLoading: false,
      );
    } catch (e) {
      _searchModel = _searchModel.copyWith(
        isLoading: false,
        errorMessage: 'Search failed. Please try again.',
      );
    }
    notifyListeners();
  }

  void clearSearch() {
    _searchController.clear();
    _searchModel = const SearchModel(
      query: '',
      results: [],
      isLoading: false,
    );
    notifyListeners();
  }

  void clearError() {
    if (_searchModel.errorMessage != null) {
      _searchModel = _searchModel.copyWith(errorMessage: null);
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
