import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../handlers/auth/create_account_handler.dart';
import '../handlers/auth/login_handler.dart';

class AuthRoutes {
  Router get route {
    final appRoute = Router();
    appRoute
      ..get("/", (Request req) {
        return Response.ok("AuthRoute");
      })
      ..post("/create_account", createAccountHandler)
      ..post("/login", loginHandler);

    return appRoute;
  }
}
