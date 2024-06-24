import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:investment_app/src/core/constant/string.dart';
import 'package:investment_app/src/core/service/storage/secure_storage.dart';
import 'package:investment_app/src/features/auth/data/datasource/firebase_auth_datasource.dart';
import 'package:investment_app/src/features/register/model/user_model.dart';

Future<int> registerUser(UserModel user) async {
  AuthServices _auth = AuthServices();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final SecureStorage _secureStorage = SecureStorage();
  final jwt = await _secureStorage.readSecureData("jwt_token");
  final url = Uri.parse('${Config.baseUrl}/update');
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $jwt'
  };
  final body = jsonEncode(user.toJson());

  final response = await http.post(url, headers: headers, body: body);

  if (response.statusCode == 200) {
    final userCredential = await _auth.getCurrentUser();

    if (userCredential != null) {
      await _firestore.collection("User").doc(userCredential.uid).set(
        {
          "uid": userCredential.uid,
          "email": userCredential.email,
        },
      );
    }
    return response.statusCode;
  } else {
    log("${response.statusCode}");
    log(response.body);
    log(jwt);
    return response.statusCode;
  }
}
