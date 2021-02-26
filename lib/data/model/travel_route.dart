class TravelRoute {
  final String from;
  final String to;
  final String departure;
  final String arrival;
  final int transferCount;
  final List<String> transfers;
  final Run run;

  TravelRoute(this.from, this.to, this.departure, this.arrival,
      this.transferCount, this.transfers, this.run);

  factory TravelRoute.fromJson(Map json, Map runJson) {
    String from = json["indulasi_hely"];
    String to = json["erkezesi_hely"];
    String departure = json["indulasi_ido"];
    String arrival = json["erkezesi_ido"];
    int transferCount = json["atszallasok_szama"] ?? 0;
    List<String> transfers = [];

    //Ezt valahogy meg lehet szebben is for sure. nem kell if,
    //ha null akkor majd átiratjuk ures listara
    if (json["atszallasinfok"]["1"] != null) {
      json["atszallasinfok"].forEach((i, json) {
        if (int.parse(i) > 0) {
          transfers.add(json["atszallohely"]);
        }
      });
    }

    Run run = Run.fromJson(runJson);

    return TravelRoute(
        from, to, departure, arrival, transferCount, transfers, run);
  }
}

class Run {
  final int runId;
  final String delay; //TODO: use correct time class, not string
  final String renCAM;
  final bool tracked; //idk miez
  //TODO: FUCKING COORDINATES???? IDK CLASS FOR THAT
  Run(this.runId, this.delay, this.renCAM, this.tracked);

  factory Run.fromJson(Map runJson) {
    int runId = (runJson["result"]["data"][0]["run_id"] is String
        ? int.parse(runJson["result"]["data"][0]["run_id"])
        : runJson["result"]["data"][0]["run_id"]);
    String delay = runJson["result"]["data"][0]["delay"];
    String renCAM = runJson["result"]["data"][0]["regnum"];
    bool tracked =
        runJson["result"]["data"][0]["tracked"] == "true" ? true : false;
//  runJson["result"]["data"]["geom"]["coordinates"]
    return Run(runId, delay, renCAM, tracked);
  }
}
