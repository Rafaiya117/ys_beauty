import 'package:flutter/material.dart';
import '../model/events_model.dart';
import '../repository/events_repository.dart';

class EventsViewModel extends ChangeNotifier {
  final EventsRepository _repository = EventsRepository();
  
  EventsModel _model = EventsModel();
  EventsModel get model => _model;

  bool get isLoading => _model.isLoading;
  String? get errorMessage => _model.errorMessage;
  List<EventItem> get events => _model.events;
  String get selectedTab => _model.selectedTab;
  String get searchQuery => _model.searchQuery;

  List<EventItem> get filteredEvents {
    List<EventItem> filtered = events.where((event) => event.category == selectedTab).toList();
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((event) => 
        event.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
        event.location.toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    return filtered;
  }

  Future<void> loadEvents() async {
    _updateModel(_model.copyWith(isLoading: true, errorMessage: null));
    
    try {
      final events = await _repository.getEvents();
      _updateModel(_model.copyWith(
        isLoading: false,
        events: events,
      ));
    } catch (e) {
      _updateModel(_model.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load events: ${e.toString()}',
      ));
    }
  }

  void setSelectedTab(String tab) {
    _updateModel(_model.copyWith(selectedTab: tab));
  }

  void setSearchQuery(String query) {
    _updateModel(_model.copyWith(searchQuery: query));
  }

  void _updateModel(EventsModel newModel) {
    _model = newModel;
    notifyListeners();
  }

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.yellow;
      case 'approved':
        return Colors.green;
      case 'paid':
        return Colors.green;
      case 'denied':
        return Colors.red;
      case 'unpaid':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
