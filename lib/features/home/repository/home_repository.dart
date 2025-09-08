import '../model/home_model.dart';

class HomeRepository {
  // Simulate API call to get home data
  Future<HomeModel> getHomeData() async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));
      
      // Simulate successful data fetch
      return const HomeModel(
        successMessage: 'Home data loaded successfully',
      );
    } catch (e) {
      return HomeModel(
        errorMessage: 'Failed to load home data',
      );
    }
  }
}
