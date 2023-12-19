import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'user_routes.dart';

class MainRoutes {
  Handler get route {
    final appRoute = Router();
    appRoute
      ..mount("/mywebsite", UserRoutes().route)
      ..all("/<ignored|.*>", (Request req) {
        return Response.ok("sorry page nottt found");
      });
    final pipeline = Pipeline().addMiddleware(checkType()).addHandler(appRoute);

    return pipeline;
  }

  Middleware checkType() => ((innerHandler) => (Request req) {
        print(req.url.toString());
        if (req.headers["type"] == "user") {
          return innerHandler(req);
        }
        return Response.badRequest();
      });
}
