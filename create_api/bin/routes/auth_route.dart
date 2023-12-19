import 'package:shelf_router/shelf_router.dart';
import '../handlers/auth/login.dart';
import '../handlers/auth/register.dart';

class AuthRoute {
  Router get authRoute {
    final route = Router();
    route
      ..post("/login", login)
      ..post("/register", register);
    return route;
  }
}
