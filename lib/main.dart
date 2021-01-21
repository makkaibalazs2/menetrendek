import 'package:flutter/material.dart';
import 'model/travel_route.dart';
import 'api.dart';
import 'ui/routetile.dart';
//ennél el kéne érni, hogy minden dart file egy package legyen
//és "package:fájl"

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menetrendek',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(title: 'Menetrendek'),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<TravelRoute> routes = [];
  bool _loading = false;
  final _from = TextEditingController();
  final _to = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    _from.dispose();
    _to.dispose();
    super.dispose();
  }

  _refresh() async {
    setState(() {
      routes = []; // For empty list use [], NEVER null
      _loading = true;
    });

    routes = await Api.getRoutes(
        _from.text, _to.text, DateTime.now(), TravelType.any);

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          hintText: "Honnan",
                          border: OutlineInputBorder(),
                        ),
                        controller: _from,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: "Hová",
                          border: OutlineInputBorder(),
                        ),
                        controller: _to,
                      ),
                    ],
                  ),
                ),
                TextButton(
                  child: Text("Lekérés"),
                  onPressed: _refresh,
                ),
              ],
            ),
            routes != [] // Nem kell zárójel ilyenkot
                ? Column(
                    children: routes.map((route) => InfoTile(route)).toList(),
                  )
                : _loading
                    ? CircularProgressIndicator()
                    : Container(),
          ],
        ),
      ),
      // Ahhoz, hogy rendesen formázzon ilyen lépcsőzetesen, argumentumok után mindig rakj vesszőt! utolsó után is.
    );
  }
}
