import 'package:shelf_router/shelf_router.dart';
import '../handlers/create_account._hendler.dart';

class CreateAccountRouter {
  Router get createAccountRouter {
    final createAccountRouter = Router();
    createAccountRouter.post('/', createAccount);
    return createAccountRouter;
  }
}
