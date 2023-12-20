import 'package:shelf_router/shelf_router.dart';
import '../handlers/profile/delete_account_handler.dart';
import '../handlers/profile/edit_profile_handler.dart';
import '../handlers/profile/profileHandler.dart';

class UserRoutes {
  Router get route {
    final userRoute = Router();
    userRoute
      ..get('/profile', getProfileHandler)
      ..post('/edit-profile', postProfileHandler)
      ..delete('/delete-account', deleteAccountHandler);
    return userRoute;
  }
}
