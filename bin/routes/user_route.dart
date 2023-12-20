import 'package:shelf_router/shelf_router.dart';

import '../handlers/user_route_handler.dart';

class UserRoute {
  Router get route {
    final appRoute = Router();
    appRoute
      ..post('/signup', signupUser)
      ..post('/login', loginUser)
      ..post('/profile', userProfile)
      ..post('/delete_account', deleteAccount)
      ..get('/get_profile', getUserProfile);
    return appRoute;
  }
}
