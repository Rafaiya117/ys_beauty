import 'package:flutter/material.dart';
import '../model/events_model.dart';
import '../repository/events_repository.dart';

class EventsViewModel extends ChangeNotifier {
  final EventsRepository _repository = EventsRepository();

  EventsModel _model = EventsModel();
  EventsModel get model => _model;

  // Search properties
  String? _searchFilterType;
  final TextEditingController _searchController = TextEditingController();

  bool get isLoading => _model.isLoading;
  String? get errorMessage => _model.errorMessage;
  List<EventItem> get events => _model.events;
  String get selectedTab => _model.selectedTab;
  String get searchQuery => _model.searchQuery;
  String? get searchFilterType => _searchFilterType;
  TextEditingController get searchController => _searchController;
  

  List<EventItem> get filteredEvents {
    List<EventItem> filtered;

    if (selectedTab == 'Today' ||
        selectedTab == 'Upcoming' ||
        selectedTab == 'Past') {
      // For Today, Upcoming, and Past tabs, events are already filtered from API
      filtered = events;
    } else {
      // For other tabs, filter by category
      filtered = events.where((event) => event.category == selectedTab).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where(
      (event) =>event.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
      event.location.toLowerCase().contains(searchQuery.toLowerCase(),),).toList();
    }
    return filtered;
  }

  Future<void> loadEvents() async {
    _updateModel(_model.copyWith(isLoading: true, errorMessage: null));

    try {
      List<EventItem> events;

      if (selectedTab == 'Today') {
        // Load today's events from API
        events = await _repository.getTodayEvents();
      } else if (selectedTab == 'Upcoming') {
        // Load upcoming events from API
        events = await _repository.getUpcomingEvents();
      } else if (selectedTab == 'Past') {
        // Load past events from API
        events = await _repository.getPastEvents();
      } else {
        // Fallback to dummy events for unknown tabs
        final allEvents = await _repository.getEvents();
        events = allEvents
            .where((event) => event.category == selectedTab)
            .toList();
      }

      _updateModel(_model.copyWith(isLoading: false, events: events));
    } catch (e) {
      _updateModel(
        _model.copyWith(
          isLoading: false,
          errorMessage: 'Failed to load events: ${e.toString()}',
        ),
      );
    }
  }

  void setSelectedTab(String tab) {
    _updateModel(_model.copyWith(selectedTab: tab));
    // Reload events when tab changes to get fresh data for Today tab
    loadEvents();
  }

  void setSearchQuery(String query) {
    _updateModel(_model.copyWith(searchQuery: query));
    _searchController.text = query;
  }

  void setSearchFilterType(String? filterType) {
    _searchFilterType = filterType;
    // Clear search when changing filter type
    _updateModel(_model.copyWith(searchQuery: ''));
    _searchController.clear();
    notifyListeners();
  }

  void clearSearch() {
    _updateModel(_model.copyWith(searchQuery: ''));
    _searchController.clear();
    notifyListeners();
  }

  void clearSearchFilter() {
    _searchFilterType = null;
    _updateModel(_model.copyWith(searchQuery: ''));
    _searchController.clear();
    notifyListeners();
  }

  void _updateModel(EventsModel newModel) {
    _model = newModel;
    notifyListeners();
  }

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return const Color(0xFFEEBC20); // Yellow background for Pending
      case 'approved':
        return const Color(0xFF00BF63); // Green background for Approved
      case 'paid':
        return const Color(0xFF00703A); // Dark green background for Paid
      case 'denied':
        return const Color(0xFFFF5151);
      case 'unpaid':
        return const Color(0xFFEF4444);
      default:
        return Colors.grey;
    }
  }

  // Dispose method to clean up controller
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
