import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'user_route.dart';

class MainRoute {
  Handler get route {
    final appRoute = Router();
    appRoute
      ..get('/', (Request req) {
        return Response.ok("body");
      })
      ..mount("/user", UserRoute().route)
      ..all('/<ignore|.*>', (Request req) {
        return Response.ok("sorry");
      });

    return appRoute;
  }
}
