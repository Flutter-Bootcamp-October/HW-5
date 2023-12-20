import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../handlers/deletprofilehandler.dart';
import '../handlers/getprofilehandler.dart';
import '../handlers/profilehandler.dart';
import '../handlers/signup.dart';
import '../handlers/signin.dart';

class UserRoutes {
  Handler get route {
    final appRoutes = Router();

    appRoutes
      ..get("/", (Request req) {
        return Response.ok("here is a user route");
      })
      ..post("/signup", signupHandler)
      ..post('/signin', signinHandler)
      ..post('/profile', profileHandler)
      ..get('/get_profile', getProfileHandler)
    ..delete('/delete_profile', deleteProfileHandler);

    return appRoutes;
  }
}
