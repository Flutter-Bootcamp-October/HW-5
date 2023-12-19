import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../handlers/create_handler.dart';
import '../handlers/delete_handler.dart';
import '../handlers/edit_handler.dart';
import '../handlers/home_handler.dart';
import '../handlers/login_handler.dart';
import '../handlers/profile_handler.dart';

class UserRoutes {
  Router get route {
    final appRoute = Router();
    appRoute
      ..post("/home", homeHandler)
      ..post("/login", loginHandler)
      ..get("/profile", profileHandler)
      ..post("/create_account", createHandler)
      ..post("/edit_profile", editHandler)
      ..delete("/delete_account", deleteHandler)
      ..all("/<ignored|.*>", (Request req) {
        return Response.ok("sorry page not found2");
      });
    // final pipeline =
    //     Pipeline().addMiddleware(checkToken()).addHandler(appRoute);

    return appRoute;
  }

  // Middleware checkToken() => ((innerHandler) => (Request req) {
  //       if (req.headers["token"] != null) {
  //         return innerHandler(req);
  //       }
  //       return Response.badRequest(body: "token is missing");
  //     });
}
