import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../handlers/user/createAccountHandler.dart';
import '../handlers/user/deleteAccountHandler.dart';
import '../handlers/user/editProfileHandler.dart';
import '../handlers/user/getProfileHandler.dart';
import '../handlers/user/loginHandlers.dart';

class UserRoutes {
  Handler get route {
    final appRoutes = Router();

    appRoutes
      ..post('/login', loginHandler)
      ..post('/create_account', createAccountHandler)
      ..get('/profile', getProfileHandler)
      ..post('/edit_profile', editProfileHandler)
      ..delete('/delete-account', deleteAccountHandler);

    return appRoutes;
  }
}
