import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

String apiToken = '';
Future<void> getAccessToken() async {
  await dotenv.load(fileName: ".env");
  final url = Uri.parse('https://api.eagle-iot.com/v2/user/login');
  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      "email": dotenv.env['email'],
      "password": dotenv.env['password'],
      "short_name": dotenv.env['short_name']
    }),
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseBody = jsonDecode(response.body);
    apiToken = responseBody['data']['reply']['token'];
  }
}
