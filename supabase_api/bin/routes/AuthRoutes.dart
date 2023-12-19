import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../handler/auth/create_account_handler.dart';
import '../handler/auth/loginHandlers.dart';
import '../handler/user_handler/delete_account_handler.dart';
import '../handler/user_handler/edit_profile_handler.dart';
import '../handler/user_handler/profile_handler.dart';

class AuthRoutes {
  Handler get route {
    final appRoutes = Router();

    appRoutes
      ..get("/", (Request req) {
        return Response.ok("AuthRoutes");
      })
      ..post("/create_account", createAccountHandler)
      ..post("/login", loginHandler)
      ..get("/profile", profileHandler)
      ..post("/edit-profile", editProfileHandler)
      ..delete("/delete-account", deleteAccountHandler);

    return appRoutes;
  }
}
