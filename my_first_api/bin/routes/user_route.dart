import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../handlers/user_handlers/delete_account_handler.dart';
import '../handlers/user_handlers/get_profile_handler.dart';
import '../handlers/user_handlers/post_profile_handler.dart';
import '../handlers/user_handlers/upload_avatar.dart';
import '../middlewares/user_middleware.dart';

class UserRoute {
  Handler get route {
    final Router appRoute = Router()
      ..post("/edit-profile", postProfileHandler)
      ..get("/profile", getProfileHandler)
      ..post("/upload-avatar", uploadAvatarHandler)
      ..delete("/delete-account", deleteAccountHandler);

    final pipe = Pipeline().addMiddleware(checkToken()).addHandler(appRoute);

    return pipe;
  }
}
