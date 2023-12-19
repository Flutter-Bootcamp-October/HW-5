import 'package:shelf_router/shelf_router.dart';
import '../handlers/delete_account_handler.dart';

class DeleteAccountRoutes {
  Router get route {
    final appRoute = Router();
    appRoute.delete("/", deleteAccountHandler);

    return appRoute;
  }
}
