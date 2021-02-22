import 'package:flutter/material.dart';
import 'package:menetrend/api.dart';
import 'package:menetrend/data/model/station.dart';
import 'package:menetrend/data/model/travel_route.dart';
import 'package:menetrend/ui/page/route/tile.dart';
import 'package:textfield_search/textfield_search.dart';

class RoutePage extends StatefulWidget {
  @override
  _RoutePageState createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  List<TravelRoute> routes = [];
  bool _loading = false;
  final _fromController = TextEditingController();
  final _toController = TextEditingController();
  TextEditingController dateCtl = TextEditingController();

  DateTime date =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  TravelType selectedTravelType = TravelType.any;

  Future<List> fetchStationNames(TextEditingController ctl) async {
    List<Station> stations = await Api.getStations(ctl.text);
    stations ??= <Station>[];
    return stations.map((e) => e.stopName).toList();
  }

  @override
  void initState() {
    dateCtl.text = date.toString().substring(0, 11);
    // _fromController.addListener(fetchStationNames(_fromController));
    // _toController.addListener(fetchStationNames(_toController));
    super.initState();
  }

  void dispose() {
    _fromController.dispose();
    _toController.dispose();
    super.dispose();
  }

  Future _refresh() async {
    setState(() {
      routes = [];
      _loading = true;
    });

    routes = await Api.getRoutes(
        _fromController.text, _toController.text, date, selectedTravelType);

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black38),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: TextFieldSearch(
                            future: () => fetchStationNames(_fromController),
                            label: "Kezdőállomás",
                            controller: _fromController,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          height: 50,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black38),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: TextFieldSearch(
                            future: () => fetchStationNames(_toController),
                            label: "Célállomás",
                            controller: _toController,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          height: 50,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black38),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: TextFormField(
                            controller: dateCtl,
                            decoration: InputDecoration(
                              labelText: "Dátum",
                              hintText: "Válaszd ki a dátumot",
                            ),
                            onTap: () async {
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                              date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2021),
                                  lastDate: DateTime(2023));
                              dateCtl.text = date.toString().substring(0, 11);
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          height: 50,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(color: Colors.black38),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<TravelType>(
                              dropdownColor: Theme.of(context).backgroundColor,
                              isExpanded: true,
                              value: selectedTravelType,
                              onChanged: (value) => setState(() {
                                selectedTravelType = value;
                              }),
                              items: [
                                DropdownMenuItem(
                                  child: Text("Összes"),
                                  value: TravelType.any,
                                ),
                                DropdownMenuItem(
                                  child: Text("Busz"),
                                  value: TravelType.bus,
                                ),
                                DropdownMenuItem(
                                  child: Text("Vonat"),
                                  value: TravelType.train,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border.all(
                        color: Theme.of(context).accentColor,
                        width: 2,
                      ),
                    ),
                    width: 75,
                    height: 230,
                    child: InkWell(
                      child: Center(
                        child: Text(
                          "LEKÉRÉS\n(VISSZAUT)",
                          style:
                              TextStyle(color: Theme.of(context).accentColor),
                        ),
                      ),
                      onTap: () async {
                        await _refresh();
                      },
                      onLongPress: () async {
                        var temp = _fromController.text;
                        _fromController.text = _toController.text;
                        _toController.text = temp;
                        await _refresh();
                      },
                    ),
                  )
                ],
              ),
            ),
            !_loading
                //TODO: üres listánál üzenet
                ? Column(
                    children: <Widget>[Divider()] +
                        routes.map((route) => InfoTile(route)).toList(),
                  )
                : Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
