import 'package:shelf_router/shelf_router.dart';

import '../handlers/login_handler.dart';

class LoginRouter {
  Router get loginRouter {
    final loginRouter = Router();
    loginRouter.post('/', login);
    return loginRouter;
  }
}
