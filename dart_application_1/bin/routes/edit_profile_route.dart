import 'package:shelf_router/shelf_router.dart';

import '../handlers/edit_profile_handler.dart';

class EditProfileRoutes {
  Router get route {
    final appRoute = Router();
    appRoute.post("/", editProfileHandler);

    return appRoute;
  }
}
