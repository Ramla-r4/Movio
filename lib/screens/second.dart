import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Map<String, String>>> fetchRecommendations(
    String description) async {
  final url = Uri.parse('http://127.0.0.1:8000'); // Your Django API endpoint

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'description': description}),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((movie) {
        return {
          'title': movie['title'] as String,
          'poster_url': movie['poster_url'] as String,
          'rating': movie['rating']?.toString() ??
              'N/A', // Ensure rating is properly fetched
        };
      }).toList();
    } else {
      throw Exception('Failed to load recommendations');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}
