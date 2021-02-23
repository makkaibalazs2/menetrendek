class Station {
  String settlementName;
  String stopName;
  int settlementId;
  int stopId;
  Station(this.settlementName, this.stopName, this.settlementId, this.stopId);
  factory Station.fromJson(Map json) {
    String settlementName = json["settlement_name"] ?? "";
    String stopName = json["lsname"] ?? "";

    int settlementId;
    int stopId;
    if (json["settlement_id"] is String)
      settlementId = int.parse(json["settlement_id"]);
    else
      settlementId = json["settlement_id"] ?? 0;
    if (json["ls_id"] is String)
      stopId = int.parse(json["ls_id"]);
    else
      stopId = json["ls_id"] ?? 0;

    return Station(settlementName, stopName, settlementId, stopId);
  }
}