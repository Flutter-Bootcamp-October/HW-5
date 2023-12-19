import 'package:shelf_router/shelf_router.dart';
import '../handlers/create_account_handler.dart';

class CreateAccountRoutes {
  Router get route {
    final appRoute = Router();
    appRoute.post("/", createAccountHandler);
    return appRoute;
  }
}
