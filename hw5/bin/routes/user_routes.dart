import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../handlers/user/delete_account_handller.dart';
import '../handlers/user/edit_profile_handler.dart';
import '../handlers/user/profile_handler.dart';

class UserRoutes {
  Router get route {
    final appRoute = Router();
    appRoute
      ..get("/", (Request req) {
        return Response.ok("UserRoute");
      })
      ..get("/profile", profilleHandler)
      ..post("/edit_profile", editHandler)
      ..delete("/delete_profile", deleteHandler);

    return appRoute;
  }
}
