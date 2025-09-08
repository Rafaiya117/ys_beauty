import '../model/search_model.dart';

class SearchRepository {
  // Mock search data
  final List<SearchResult> _mockResults = [
    const SearchResult(
      id: '1',
      title: 'Friendly Party',
      date: 'July 22, 2025',
      location: 'Bardessono - Yountville, CA',
      type: 'event',
      description: 'A fun gathering with friends and family',
    ),
    const SearchResult(
      id: '2',
      title: 'Birthday Celebration',
      date: 'July 25, 2025',
      location: 'Downtown Event Center',
      type: 'event',
      description: 'Birthday party celebration',
    ),
    const SearchResult(
      id: '3',
      title: 'Corporate Event',
      date: 'July 28, 2025',
      location: 'Grand Hotel Ballroom',
      type: 'event',
      description: 'Annual corporate gathering',
    ),
    const SearchResult(
      id: '4',
      title: 'Wedding Reception',
      date: 'August 5, 2025',
      location: 'Garden Venue',
      type: 'event',
      description: 'Beautiful wedding celebration',
    ),
    const SearchResult(
      id: '5',
      title: 'Conference 2025',
      date: 'August 10, 2025',
      location: 'Convention Center',
      type: 'event',
      description: 'Annual business conference',
    ),
  ];

  Future<List<SearchResult>> search(String query) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    if (query.isEmpty) {
      return [];
    }
    
    // Simple search logic - filter by title, location, or date
    return _mockResults.where((result) {
      final searchLower = query.toLowerCase();
      return result.title.toLowerCase().contains(searchLower) ||
             result.location.toLowerCase().contains(searchLower) ||
             result.date.toLowerCase().contains(searchLower) ||
             (result.description?.toLowerCase().contains(searchLower) ?? false);
    }).toList();
  }
}
