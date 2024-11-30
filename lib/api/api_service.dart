import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kfupm_smart_bus_system/api/access_token.dart';
import 'package:firebase_database/firebase_database.dart';

final databaseRef = FirebaseDatabase.instance.ref();

final busIds = [
  276,
  261,
  258,
  251,
  250,
  249,
  248,
  247,
  246,
  245,
  244,
  243,
  242,
  241,
  240,
  239,
  238,
  237,
  236,
  235,
  229,
  228,
  227,
  226,
  225,
  224,
  223,
  222,
  221,
  220,
  218,
  217,
  216,
  215,
  214,
  213,
  212,
  211,
  210,
  209,
  198,
  197,
  187,
  186,
  185,
  184,
  183,
  182,
  181,
  180,
  176,
  175,
  174,
  173,
  172,
  171,
  168,
  167,
  166,
  15,
  14,
  12,
  9
];

String? apiToken;
bool tokenFound = false;

Stream<List<dynamic>> getAssetsLatestPositionsStream() {
  return Stream.periodic(
          const Duration(seconds: 5), (_) => _fetchBusLocations())
      .asyncExpand((futureList) async* {
    yield await futureList;
  });
}

Future<List<dynamic>> _fetchBusLocations() async {
  if (!tokenFound) apiToken = await getAccessTokenFromFirebase();
  final url = Uri.parse(
      'https://api.eagle-iot.com/v2/Tracking/GetAssetsLatestPositions');
  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiToken',
    },
    body: jsonEncode({"assetIds": busIds}),
  );

  if (response.statusCode == 200) {
    tokenFound = true;
    final Map<String, dynamic> responseBody = jsonDecode(response.body);
    List<dynamic> dataReply = responseBody['data']['reply'];
    List<dynamic> busesLocation = [];
    for (var bus in dataReply) {
      if (bus['assetInfo']['hasCommunicatedInLast3Hours'] &&
          bus['locationLog']['ignitionStatus'] == 1) {
        var assetId = bus['locationLog']['assetId'];
        var locationLog = [
          bus['locationLog']['latitude'] ?? 0.0,
          bus['locationLog']['longitude'] ?? 0.0
        ];
        Map<String, dynamic> busInfo = {
          'assetId': assetId,
          'locationLog': locationLog
        };
        busesLocation.add(busInfo);
      }
    }
    return busesLocation;
  } else if (response.statusCode == 403) {
    tokenFound = false;
    await getAccessToken();
    return _fetchBusLocations();
  }
  return [];
}
