import 'dart:convert';

import 'package:animation/core/token_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
  // Future<void> search(String query) async {
  //   if (query.trim().isEmpty) {
  //     _searchModel = _searchModel.copyWith(
  //       query: '',
  //       results: [],
  //       isLoading: false,
  //       errorMessage: null,
  //     );
  //     notifyListeners();
  //     return;
  //   }

  //   _searchModel = _searchModel.copyWith(
  //     query: query,
  //     isLoading: true,
  //     errorMessage: null,
  //   );
  //   notifyListeners();

  //   try {
  //     final results = await _repository.search(query);
  //     _searchModel = _searchModel.copyWith(
  //       results: results,
  //       isLoading: false,
  //     );
  //   } catch (e) {
  //     _searchModel = _searchModel.copyWith(
  //       isLoading: false,
  //       errorMessage: 'Search failed. Please try again.',
  //     );
  //   }
  //   notifyListeners();
  // }
List<SearchResult> searchResults = [];
bool isSearching = false;

Future<void> search(String query) async {
  if (query.isEmpty) return;

  isSearching = true;
  notifyListeners(); // 👀 tell UI “loading started”

  try {
    final String baseUrl = 'http://10.10.13.36/event/events/search_event/';
    final accessToken = await TokenStorage.getAccessToken();
    final url = Uri.parse('$baseUrl?q=$query');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );

    print('🔍 Search URL: $url');
    print('📦 Status Code: ${response.statusCode}');
    print('📩 Body: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      searchResults = data.map((json) {
        return SearchResult(
          id: json['id'].toString(),
          title: json['event_name'] ?? '',
          date: json['date'] ?? '',
          location: json['address'] ?? '',
          type: 'event',
          description: json['description'] ?? '',
        );
      }).toList();
    } else {
      searchResults = [];
    }
  } catch (e) {
    print('❌ Search failed: $e');
    searchResults = [];
  }

  isSearching = false;
  notifyListeners(); // 🔥 tell UI “done loading”
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
