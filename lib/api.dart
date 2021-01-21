import 'dart:convert';

import 'package:http/http.dart' as http;
import 'travel_route.dart';

enum TravelType { any, bus, train }

_travelTypeToInt(TravelType type) {
  switch (type) {
    case TravelType.any:
      return 0;
    case TravelType.bus:
      return 1;
    case TravelType.train:
      return 4;
    default:
      return 0;
  }
}

class Api {
  static Future<List<TravelRoute>> getRoutes(
      String from, String to, DateTime date, TravelType travelType) async {
    try {
      final response = await http
          .post("https://menetrendek.hu/menetrend/interface/index.php", body: {
        "json": jsonEncode({
          "func": "getRoutes",
          "params": {
            "datum": date.toString(),
            "honnan": from,
            "hova": to,
            "naptipus": 0,
            "hour": 0,
            "min": 0,
            "preferencia": _travelTypeToInt(travelType)
          }
        })
      });

      if (response.statusCode != 200) throw "Invalid response";

      Map<String, dynamic> responseJson = jsonDecode(response.body);
      List<TravelRoute> schedules = [];

      (responseJson["results"]["talalatok"] as Map<String, Object>)
          .forEach((key, json) => schedules.add(TravelRoute.fromJson(json)));

      return schedules;
    } catch (error) {
      print("ERROR: Api.getSchedules: " + error.toString());
    }
    return [];
  }
}
