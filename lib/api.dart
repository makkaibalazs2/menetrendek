import 'dart:convert';
// import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:menetrend/data/model/station.dart';
import 'package:menetrend/data/model/travel_route.dart';

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

      Map responseJson = jsonDecode(response.body);
      List<TravelRoute> schedules = [];

      responseJson["results"]["talalatok"].forEach((String key, json) {
        getRun(int.parse(json["nativeData"]["RunId"])).then((runJson) {
          schedules.add(TravelRoute.fromJson(json, runJson));
        });
      });

      return schedules;
    } catch (error) {
      print("ERROR: Api.getSchedules: " + error.toString());
    }
    return [];
  }

  static Future<Map> getRun(int runId) async {
    try {
      final response = await http
          .post("https://menetrendek.hu/menetrend/interface/index.php", body: {
        {
          "func": "getRunsDelay",
          "params": {
            "runs": [runId]
          }
        }
      });
      Map responseJson = jsonDecode(response.body);
      return responseJson;
    } catch (error) {
      print("ERROR: Api.getExtendedData: " + error.toString());
    }
    return {};
  }

  static Future<List<Station>> getStations(String name) async {
    try {
      final response = await http
          .post("https://menetrendek.hu/menetrend/interface/index.php", body: {
        "json": jsonEncode({
          "func": "getStationOrAddrByText",
          "params": {
            "inputText": name,
            "searchIn": ["stations"], // <- ide kéne vmi?
            "searchDate": "2021-02-23",
            "maxResults": 30,
            "networks": [1, 2, 3, 10, 11, 12, 13, 14, 24],
            "currentLang": "hu"
          }
        })
      });
      List<Station> stations = [];
      Map responseJson = jsonDecode(response.body);
      print(response.body);
      responseJson["results"].forEach((e) {
        stations.add(Station.fromJson(e));
      });
      return stations;
    } catch (error) {
      print("ERROR: Api.getStations: " + error.toString());
    }
    return [];
  }
}
