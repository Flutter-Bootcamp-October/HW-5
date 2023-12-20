import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../handlers/auth/create_account_handler.dart';
import '../handlers/auth/login_handler.dart';

class AuthRoutes {
  Router get route {
    final appRoutes = Router();
    appRoutes
      ..get("/", (Request req) {
        return Response.ok("Welcome in auth page");
      })
      ..post('/login', loginHandler)
      ..post('/create_account', createAccountHandler)
      ..all('/<ignore|.*>', (Request req) {
        return Response.notFound("Sorry not found the auth page");
      });

    return appRoutes;
  }
}//login & create account 