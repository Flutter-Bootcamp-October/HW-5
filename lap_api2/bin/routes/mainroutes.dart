import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'userroutes.dart';



class MainRoutes {
  Handler get route {
    final appRoutes = Router();
    appRoutes
      ..get("/", (Request req) {
        return Response.ok("here is a main routes");
      })
     
      ..mount('/user', UserRoutes().route)
      ..all('/<ignore|.*>', (Request req) {
        return Response.notFound("Sorry not found you page");
      });
       return appRoutes;
  }
}
