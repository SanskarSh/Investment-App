import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:investment_app/src/core/constant/string.dart';
import 'package:investment_app/src/core/service/storage/secure_storage.dart';
import 'package:investment_app/src/features/explore_feed/model/blog_model.dart';

class VideoApiService {
  final SecureStorage _secureStorage = SecureStorage();

  Future<List<VideoModel>> getVideos() async {
    try {
      final jwt = await _secureStorage.readSecureData("jwt_token");
      final url = Uri.parse('${Config.baseUrl}/learning/videos');
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt'
      };
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = jsonDecode(response.body);
        if (body['type'] == 'success' && body.containsKey('data')) {
          List<dynamic> data = body['data'];
          return data.map((item) => VideoModel.fromJson(item)).toList();
        } else {
          throw Exception("Unexpected response format");
        }
      } else {
        log("HTTP ${response.statusCode}: ${response.reasonPhrase}");
        log("Response body: ${response.body}");
        throw Exception(
            "Failed to load modules with status code ${response.statusCode}");
      }
    } catch (e) {
      log("Error occurred: $e");
      throw Exception("Failed to load modules: $e");
    }
  }
}
