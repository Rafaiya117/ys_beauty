import 'package:flutter/material.dart';
import '../model/navigation_model.dart';

class NavigationViewModel extends ChangeNotifier {
  late NavigationModel _navigationModel;

  // Constructor - initialize data immediately
  NavigationViewModel({int initialIndex = 0}) {
    _initializeData(initialIndex);
  }

  // Getters
  NavigationModel get navigationModel => _navigationModel;
  int get currentIndex => _navigationModel.currentIndex;
  bool get isAddNewModalOpen => _navigationModel.isAddNewModalOpen;

  void _initializeData(int initialIndex) {
    _navigationModel = NavigationModel(currentIndex: initialIndex);
    notifyListeners();
  }

  // Change current tab
  void changeTab(int index) {
    _navigationModel = _navigationModel.copyWith(currentIndex: index);
    notifyListeners();
  }

  // Open add new modal
  void openAddNewModal() {
    _navigationModel = _navigationModel.copyWith(isAddNewModalOpen: true);
    notifyListeners();
  }

  // Close add new modal
  void closeAddNewModal() {
    _navigationModel = _navigationModel.copyWith(isAddNewModalOpen: false);
    notifyListeners();
  }
}
