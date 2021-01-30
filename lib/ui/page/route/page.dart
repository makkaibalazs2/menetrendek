import 'package:flutter/material.dart';
import 'package:menetrend/api.dart';
import 'package:menetrend/model/travel_route.dart';
import 'package:menetrend/ui/page/route/tile.dart';

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
  
 // DateTime date = DateTime.now();
  DateTime date = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);  // ez a jo


  TravelType selectedTravelType = TravelType.any;
  @override
  void initState() {
      dateCtl.text = date.toString();
      
    super.initState();
  }

  void dispose() {
    _fromController.dispose();
    _toController.dispose();
    super.dispose();
  }

  _refresh() async {
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
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Honnan",
                              border: OutlineInputBorder(),
                            ),
                            controller: _fromController,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          height: 50,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Hová",
                              border: OutlineInputBorder(),
                            ),
                            controller: _toController,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          height: 50,
                          child: TextFormField(
                            controller: dateCtl,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
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
                              dateCtl.text = date.toString();
                            },
                          ),
                        ), //<- figyeld a kulonbseget. mindig legyen vesszo, és akkor a lezárásokat látod rendesen. vili?
                        Container(
                          // ctrl+shift+i, ne kezzel tabold be nekem az nem mukodik valamiert lol
                          // akkor nem engedi, ha error van. check problems
                          margin: EdgeInsets.only(top: 10),
                          height: 50,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            border: Border.all(color: Colors.black38),
                          ),
                            child: DropdownButtonHideUnderline(
                          child: DropdownButton<TravelType>(
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
                        color: Colors.blueAccent,
                        width: 2,
                      ),
                    ),
                    width: 75,
                    height: 230,
                    child: InkWell(
                      child: Center(
                        child: Text(
                          "LEKÉRÉS",
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                      ),
                      onTap: () async {
                        _refresh();
                      },
                    ),
                  )
                ],
              ),
            ),
            !_loading
                //TODO: üres listánál üzenet
                ? Column(
                    children: routes.map((route) => InfoTile(route)).toList(),
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
