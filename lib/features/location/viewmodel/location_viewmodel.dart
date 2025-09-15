import 'package:flutter/material.dart';
import '../model/location_model.dart';
import '../../../shared/constants/app_constants.dart';

class LocationViewModel extends ChangeNotifier {
  final List<LocationModel> _locations = [];
  bool _isLoading = false;
  String _searchQuery = '';
  LocationModel? _selectedLocation;
  final TextEditingController _searchController = TextEditingController();

  // Getters
  List<LocationModel> get locations => _locations;
  bool get isLoading => _isLoading;
  String get searchQuery => _searchQuery;
  LocationModel? get selectedLocation => _selectedLocation;
  TextEditingController get searchController => _searchController;

  // Initialize with sample data
  void initializeLocations() {
    _isLoading = true;
    notifyListeners();

    // Simulate loading delay
    Future.delayed(const Duration(milliseconds: 500), () {
      _locations.clear();
      _locations.addAll([
        const LocationModel(
          id: '1',
          name: 'Center',
          address: 'Center, Colorado',
          latitude: 37.8,
          longitude: -106.1,
          imagePath: AppConstants.mapImagePath,
        ),
        const LocationModel(
          id: '2',
          name: 'Monte Vista',
          address: 'Monte Vista, Colorado',
          latitude: 37.6,
          longitude: -106.1,
          imagePath: AppConstants.mapImagePath,
        ),
        const LocationModel(
          id: '3',
          name: 'Alamosa',
          address: 'Alamosa, Colorado',
          latitude: 37.5,
          longitude: -105.9,
          imagePath: AppConstants.mapImagePath,
        ),
        const LocationModel(
          id: '4',
          name: 'Taos',
          address: 'Taos, New Mexico',
          latitude: 36.4,
          longitude: -105.6,
          imagePath: AppConstants.mapImagePath,
        ),
        const LocationModel(
          id: '5',
          name: 'Santa Fe',
          address: 'Santa Fe, New Mexico',
          latitude: 35.7,
          longitude: -105.9,
          imagePath: AppConstants.mapImagePath,
        ),
        const LocationModel(
          id: '6',
          name: 'Pagosa Springs',
          address: 'Pagosa Springs, Colorado',
          latitude: 37.3,
          longitude: -107.0,
          imagePath: AppConstants.mapImagePath,
        ),
      ]);
      _isLoading = false;
      notifyListeners();
    });
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void selectLocation(LocationModel location) {
    _selectedLocation = location;
    notifyListeners();
  }

  List<LocationModel> get filteredLocations {
    if (_searchQuery.isEmpty) {
      return _locations;
    }
    return _locations.where((location) =>
        location.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        location.address.toLowerCase().contains(_searchQuery.toLowerCase())
    ).toList();
  }

  void clearSearch() {
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
