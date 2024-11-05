import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final databaseRef = FirebaseDatabase.instance.ref();

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
    //posting new access token to firebase
    final Map<String, dynamic> responseBody = jsonDecode(response.body);
    String _apiToken = responseBody['data']['reply']['token'].toString();
    final gpsApi = FirebaseFirestore.instance.collection('GPS_API');
    final accessTokenRef = gpsApi.doc('access_token');
    await accessTokenRef.set(
      {"access_token": _apiToken},
    );
  }
}

Future<String> getAccessTokenFromFirebase() async {
  final gpsApi = FirebaseFirestore.instance.collection('GPS_API');
  final accessTokenRef = gpsApi.doc('access_token');
  String accessToken = '';
  final docSnapshot = await accessTokenRef.get();
  if (docSnapshot.exists) {
    final data = docSnapshot.data();
    accessToken = data?['access_token'];
  }
  return accessToken;
}
