import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../handlers/user/delete_account_handler.dart';
import '../handlers/user/edit_profile_handler.dart';
import '../handlers/user/profile_handler.dart';

class UserRoutes {
  Router get route {
    final appRoutes = Router();
    appRoutes
      ..get("/", (Request req) {
        return Response.ok("Welcome in user page");
      })
      ..get('/profile', profleHandler)
      ..post('/edit_profile', editProfleHandler)
      ..delete('/delete_account', deleteAccountHandler)
      ..all('/<ignore|.*>', (Request req) {
        return Response.notFound("Sorry not found the user page");
      });

    return appRoutes;
  }
}

//profile & edit-profil & delete account