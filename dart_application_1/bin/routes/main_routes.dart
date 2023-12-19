import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../handlers/main_handler.dart';
import 'delete_account_route.dart';
import 'edit_profile_route.dart';
import 'login_route.dart';
import 'create_account_route.dart';
import 'profile.dart';

class MainRoutes {
  Router get route {
    final appRoute = Router();
    appRoute
      ..get("/", mainRoute)
      ..mount("/create_account", CreateAccountRoutes().route)
      ..mount('/login', LoginRoutes().route)
      ..mount("/profile", ProfileRoutes().route)
      ..mount("/edit_profile", EditProfileRoutes().route)
      ..mount("/delete_account", DeleteAccountRoutes().route)
      ..all("/<ignored|.*>", (Request req) {
        Response.ok("notfound");
      });
    return appRoute;
  }
}
