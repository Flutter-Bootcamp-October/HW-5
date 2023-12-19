import 'package:shelf_router/shelf_router.dart';

import '../handlers/login_handler.dart';

class LoginRoutes {
  Router get route {
    final appRoute = Router();
    appRoute.post("/", loginHandler);

    return appRoute;
  }
}
