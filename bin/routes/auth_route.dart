import 'package:shelf_router/shelf_router.dart';

import '../handlers/auth_route_handler.dart';
import '../handlers/user_root_handler.dart';

class AuthRoute {
  Router get route {
    final appRoute = Router();
    appRoute
      ..post('/signup', signupUser)
      ..post('/delete_account', deleteAccount)
      ..post('/login', loginUser);
    return appRoute;
  }
}
