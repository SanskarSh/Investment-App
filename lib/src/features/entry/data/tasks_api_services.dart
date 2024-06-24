import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:investment_app/src/core/constant/string.dart';
import 'package:investment_app/src/core/service/storage/secure_storage.dart';
import 'package:investment_app/src/features/entry/model/task_model.dart';

class TasksApiServices {
  final SecureStorage _secureStorage = SecureStorage();

  Future<List<TaskModel>> getTasks() async {
    try {
      final jwt = await _secureStorage.readSecureData("jwt_token");
      final url = Uri.parse('${Config.baseUrl}/tasks');
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt'
      };
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        if (body['type'] == 'success' && body.containsKey('tasks')) {
          List<dynamic> data = body['tasks'];
          return data.map((item) => TaskModel.fromJson(item)).toList();
        } else {
          throw Exception("Unexpected response format: $body");
        }
      } else {
        log("HTTP ${response.statusCode}: ${response.reasonPhrase}");
        log("Response body: ${response.body}");
        throw Exception(
            "Failed to load tasks with status code ${response.statusCode}");
      }
    } catch (e) {
      log("Error occurred: $e");
      throw Exception("Failed to load tasks: $e");
    }
  }
}
