import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static String baseUrl = DotEnv().env['BASE_URL']!;
  static String geminiAPI = DotEnv().env['GEMINI_API']!;
}
