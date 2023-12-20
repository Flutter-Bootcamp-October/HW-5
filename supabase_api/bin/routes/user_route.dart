import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../handler/user_handler/delete_account_handler.dart';
import '../handler/user_handler/edit_profile_handler.dart';
import '../handler/user_handler/profile_handler.dart';

class UserRoutes {
  Handler get route {
    final appRoutes = Router();

    appRoutes
      ..get("/profile", profileHandler)
      ..post("/edit-profile", editProfileHandler)
      ..delete("/delete-account", deleteAccountHandler);

    return appRoutes;
  }
}
