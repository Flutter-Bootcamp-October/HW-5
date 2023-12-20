import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../handlers/auth/createAccountHandler.dart';
import '../handlers/auth/loginHandlers.dart';

class AuthRoutes {
  Handler get route {
    final appRoutes = Router();
    appRoutes
      ..post("/create-account", createAccountHandler)
      ..post("/login", loginHandler);
    return appRoutes;
  }
}
