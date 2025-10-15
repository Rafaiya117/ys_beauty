import 'package:animation/features/home/model/event_model.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../model/home_model.dart';
import '../repository/home_repository.dart';

class HomeViewModel extends ChangeNotifier {
  final HomeRepository _repository = HomeRepository();
  
  late HomeModel _homeModel;

  // Calendar and search properties (unchanged)
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  String _searchQuery = '';
  String? _searchFilterType;
  final TextEditingController _searchController = TextEditingController();

  // Constructor
  HomeViewModel() {
    _initializeData();
  }

  // Getters
  HomeModel get homeModel => _homeModel;
  bool get isLoading => _homeModel.isLoading;
  String? get errorMessage => _homeModel.errorMessage;
  String? get successMessage => _homeModel.successMessage;
  List<Event> get events => _homeModel.events; 

  DateTime get focusedDay => _focusedDay;
  DateTime? get selectedDay => _selectedDay;
  CalendarFormat get calendarFormat => _calendarFormat;
  String get searchQuery => _searchQuery;
  String? get searchFilterType => _searchFilterType;
  TextEditingController get searchController => _searchController;

  void _initializeData() {
    _homeModel = const HomeModel();
    _loadHomeData();
    notifyListeners();
  }

List<Event> get upcomingEvents => _homeModel.upcomingEvents;

Future<void> _loadHomeData() async {
  _homeModel = _homeModel.copyWith(isLoading: true);
  notifyListeners();

  try {
    final todayEvents = await _repository.getHomeData(); // returns HomeModel
    final upcomingEvents = await _repository.getUpcomingEvents(); // returns List<Event>

    _homeModel = todayEvents.copyWith(upcomingEvents: upcomingEvents);
  } catch (e) {
    _homeModel = _homeModel.copyWith(
      isLoading: false,
      errorMessage: 'An unexpected error occurred. Please try again.',
    );
  }

  notifyListeners();
}


  Future<void> refreshHomeData() async {
    await _loadHomeData();
  }

  void clearError() {
    if (_homeModel.errorMessage != null) {
      _homeModel = _homeModel.copyWith(errorMessage: null);
      notifyListeners();
    }
  }

  void clearSuccess() {
    if (_homeModel.successMessage != null) {
      _homeModel = _homeModel.copyWith(successMessage: null);
      notifyListeners();
    }
  }

  // Calendar methods (unchanged)
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

  bool hasEvents(DateTime day) => false;

  // Search methods (unchanged)
  void setSearchQuery(String query) {
    _searchQuery = query;
    _searchController.text = query;
    notifyListeners();
  }

  void setSearchFilterType(String? filterType) {
    _searchFilterType = filterType;
    _searchQuery = '';
    _searchController.clear();
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    _searchController.clear();
    notifyListeners();
  }

  void clearSearchFilter() {
    _searchFilterType = null;
    _searchQuery = '';
    _searchController.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
