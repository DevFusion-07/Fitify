import 'dart:convert';
import 'package:http/http.dart' as http;

class ImageSearchService {
  static const String _host = 'real-time-image-search.p.rapidapi.com';
  static const String _baseUrl =
      'https://real-time-image-search.p.rapidapi.com/search';

  // Provide at build time: --dart-define=RAPIDAPI_KEY=your_key
  static const String _apiKey = String.fromEnvironment('RAPIDAPI_KEY');

  // Fallback sample images for demonstration
  static const Map<String, List<String>> _fallbackImages = {
    'breakfast': [
      'https://images.unsplash.com/photo-1533089860892-a7c6f0a88666?w=400',
      'https://images.unsplash.com/photo-1551782450-17144efb9c50?w=400',
      'https://images.unsplash.com/photo-1484723091739-30a097e8f929?w=400',
    ],
    'lunch': [
      'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=400',
      'https://images.unsplash.com/photo-1546793665-c74683f339c1?w=400',
      'https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445?w=400',
    ],
    'dinner': [
      'https://images.unsplash.com/photo-1574484284002-952d92456975?w=400',
      'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=400',
      'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=400',
    ],
    'snack': [
      'https://images.unsplash.com/photo-1559181567-c3190ca9959b?w=400',
      'https://images.unsplash.com/photo-1571091718767-18b5b1457add?w=400',
      'https://images.unsplash.com/photo-1578985545062-69928b1d9587?w=400',
    ],
  };

  static Future<List<String>> search(String query, {int limit = 6}) async {
    if (_apiKey.isEmpty) {
      print('ImageSearchService: API key is empty, using fallback images');
      return _getFallbackImages(query, limit);
    }

    final uri = Uri.parse(
      '$_baseUrl'
      '?query=${Uri.encodeQueryComponent(query)}'
      '&limit=$limit'
      '&size=any&type=photo&time=any&usage_rights=any'
      '&file_type=any&aspect_ratio=any&safe_search=strict&region=us',
    );

    print('ImageSearchService: Making request to: $uri');

    final res = await http.get(
      uri,
      headers: {'x-rapidapi-host': _host, 'x-rapidapi-key': _apiKey},
    );

    print('ImageSearchService: Response status: ${res.statusCode}');
    print('ImageSearchService: Response body: ${res.body}');

    if (res.statusCode == 403) {
      print(
        'ImageSearchService: API subscription required, using fallback images',
      );
      return _getFallbackImages(query, limit);
    }

    if (res.statusCode != 200) return [];

    try {
      final data = jsonDecode(res.body) as Map<String, dynamic>;

      // Check for API error messages
      if (data.containsKey('error') || data.containsKey('message')) {
        print('ImageSearchService: API returned error: $data');
        return [];
      }

      // The API returns data in a 'data' array, not 'results'
      final list = (data['data'] as List?) ?? [];
      print('ImageSearchService: Found ${list.length} results');

      if (list.isEmpty) {
        print('ImageSearchService: No results in response');
        return [];
      }

      final imageUrls = <String>[];
      for (final item in list) {
        if (item is Map<String, dynamic>) {
          // Use thumbnail_url as the primary field based on the API response
          final imageUrl =
              item['thumbnail_url'] ??
              item['url'] ??
              item['image'] ??
              item['src'] ??
              item['link'];
          if (imageUrl is String && imageUrl.isNotEmpty) {
            imageUrls.add(imageUrl);
            print('ImageSearchService: Added URL: $imageUrl');
          }
        }
      }

      print('ImageSearchService: Extracted ${imageUrls.length} image URLs');
      return imageUrls;
    } catch (e) {
      print('ImageSearchService: Error parsing response: $e');
      return [];
    }
  }

  static List<String> _getFallbackImages(String query, int limit) {
    final queryLower = query.toLowerCase();

    for (final entry in _fallbackImages.entries) {
      if (queryLower.contains(entry.key)) {
        return entry.value.take(limit).toList();
      }
    }

    // Default to breakfast images if no match found
    return _fallbackImages['breakfast']!.take(limit).toList();
  }
}
