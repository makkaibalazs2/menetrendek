class TravelRoute {
  String from;
  String to;
  String departure;
  String arrival;
  int transferCount;
  List<String> transfers;

  TravelRoute(this.from, this.to, this.departure, this.arrival,
      this.transferCount, this.transfers);

  factory TravelRoute.fromJson(Map json) {
    String from = json["indulasi_hely"];
    String to = json["erkezesi_hely"];
    String departure = json["indulasi_ido"];
    String arrival = json["erkezesi_ido"];
    int transferCount = json["atszallasok_szama"] ?? 0;
    List<String> transfers = [];

    //Ezt valahogy meg lehet szebben is for sure. nem kell if,
    //ha null akkor majd átiratjuk ures listara
    if (json["atszallasinfok"]["1"] != null) {
      (json["atszallasinfok"] as Map<String, dynamic>).forEach((i, json) {
        if (int.parse(i) > 0) {
          transfers.add(json["atszallohely"]);
        }
      });
    }

    return TravelRoute(from, to, departure, arrival, transferCount, transfers);
  }
}
