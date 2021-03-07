import 'package:menetrend/data/model/travel_route.dart';
import 'package:menetrend/ui/page/route/tile.dart';

class RouteTileBuilder {
  List<InfoTile> tiles = [];

  build(List<TravelRoute> routes) {
    tiles = routes.map((route) => InfoTile(route)).toList();
  }
}
