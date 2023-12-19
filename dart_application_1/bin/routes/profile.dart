import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../handlers/profile_handler.dart';

class ProfileRoutes {
  Handler get route {
    final appRoute = Router();
    appRoute.get("/", profileHandler);
    return appRoute;
  }
}
