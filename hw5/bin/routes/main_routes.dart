import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../handlers/root_handler.dart';
import 'auth_routes.dart';
import 'user_routes.dart';

class MainRoutes {
  Router get route {
    final appRoute = Router();
    appRoute
      ..get("/", rootHandler)
      ..mount("/user", UserRoutes().route)
      ..mount("/auth", AuthRoutes().route)
      ..all('/<ignore|.*>', (Request req) {
        return Response.notFound("Sorry not found you page");
      });

    return appRoute;
  }
}
