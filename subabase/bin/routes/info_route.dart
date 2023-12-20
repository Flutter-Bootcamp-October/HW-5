import 'package:shelf_router/shelf_router.dart';

import '../handlers/edit_profile_handler.dart';
import '../handlers/profile_handler.dart';

class InfoRoute {
  Router get route {
    final appRoutre = Router();

    appRoutre
      ..get("/profile", profileHandler)
      ..post("/edit-profile", editeProfileHandler);

    return appRoutre;
  }
}
