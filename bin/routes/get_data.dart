import 'package:shelf_router/shelf_router.dart';

import '../handlers/user_root_handler.dart';

class ProfileRoute {
  Router get route {
    final appRoute = Router();
    appRoute.get('/get_profile', getUserProfile);
    return appRoute;
  }
}
