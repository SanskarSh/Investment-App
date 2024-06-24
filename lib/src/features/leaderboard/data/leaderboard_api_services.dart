import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:investment_app/src/core/constant/string.dart';
import 'package:investment_app/src/core/service/storage/secure_storage.dart';
import 'package:investment_app/src/features/leaderboard/model/leaderboard_model.dart';

class LeaderBoardApiServices {
  final SecureStorage _secureStorage = SecureStorage();

  Future<List<LeaderBoardModel>> getUsers() async {
    try {
      final jwt = await _secureStorage.readSecureData("jwt_token");
      final url = Uri.parse('${Config.baseUrl}/leaderboard');
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt'
      };
      final response = await http.get(url, headers: headers);
      print(response.body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = jsonDecode(response.body);
        final apiResponse = ApiResponseModel.from(body);
        if (apiResponse.type == 'success') {
          return apiResponse.leaderBoardUsers;
        } else {
          throw Exception("Unexpected response format: ${apiResponse.message}");
        }
      } else {
        log("HTTP ${response.statusCode}: ${response.reasonPhrase}");
        log("Response body: ${response.body}");
        throw Exception(
            "Failed to load leaderBoard with status code ${response.statusCode}");
      }
    } catch (e) {
      log("Error occurred: $e");
      throw Exception("Failed to load leaderBoard: $e");
    }
  }
}
