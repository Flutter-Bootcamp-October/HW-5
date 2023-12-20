import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../handler/auth/create_account_handler.dart';
import '../handler/auth/loginHandlers.dart';

class AuthRoutes {
  Handler get route {
    final appRoutes = Router();

    appRoutes
      ..post("/create_account", createAccountHandler)
      ..post("/login", loginHandler);

    return appRoutes;
  }
}
