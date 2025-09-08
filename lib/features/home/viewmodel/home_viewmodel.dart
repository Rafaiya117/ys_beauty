import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../model/home_model.dart';
import '../repository/home_repository.dart';

class HomeViewModel extends ChangeNotifier {
  final HomeRepository _repository = HomeRepository();
  
  late HomeModel _homeModel;
  
  // Calendar properties
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  
  // Search properties
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  // Constructor - initialize data immediately
  HomeViewModel() {
    _initializeData();
  }

  // Getters
  HomeModel get homeModel => _homeModel;
  bool get isLoading => _homeModel.isLoading;
  String? get errorMessage => _homeModel.errorMessage;
  String? get successMessage => _homeModel.successMessage;
  
  // Calendar getters
  DateTime get focusedDay => _focusedDay;
  DateTime? get selectedDay => _selectedDay;
  CalendarFormat get calendarFormat => _calendarFormat;
  
  // Search getters
  String get searchQuery => _searchQuery;
  TextEditingController get searchController => _searchController;

  void _initializeData() {
    _homeModel = const HomeModel();
    _loadHomeData();
    notifyListeners();
  }

  // Load home data
  Future<void> _loadHomeData() async {
    _homeModel = _homeModel.copyWith(isLoading: true);
    notifyListeners();

    try {
      final result = await _repository.getHomeData();
      _homeModel = result;
    } catch (e) {
      _homeModel = _homeModel.copyWith(
        isLoading: false,
        errorMessage: 'An unexpected error occurred. Please try again.',
      );
    }
    notifyListeners();
  }

  // Refresh home data
  Future<void> refreshHomeData() async {
    await _loadHomeData();
  }

  // Clear error message
  void clearError() {
    if (_homeModel.errorMessage != null) {
      _homeModel = _homeModel.copyWith(errorMessage: null);
      notifyListeners();
    }
  }

  // Clear success message
  void clearSuccess() {
    if (_homeModel.successMessage != null) {
      _homeModel = _homeModel.copyWith(successMessage: null);
      notifyListeners();
    }
  }
  
  // Calendar methods
  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
      notifyListeners();
    }
  }
  
  void onFormatChanged(CalendarFormat format) {
    if (_calendarFormat != format) {
      _calendarFormat = format;
      notifyListeners();
    }
  }
  
  void onPageChanged(DateTime focusedDay) {
    _focusedDay = focusedDay;
    notifyListeners();
  }
  
  // Check if a day has events
  bool hasEvents(DateTime day) {
    // In real app, this would come from your data source
    // For now, return false to remove static event markers
    return false;
  }
  
  // Search methods
  void setSearchQuery(String query) {
    _searchQuery = query;
    _searchController.text = query;
    notifyListeners();
  }
  
  void clearSearch() {
    _searchQuery = '';
    _searchController.clear();
    notifyListeners();
  }
  
  // Dispose method to clean up controller
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
