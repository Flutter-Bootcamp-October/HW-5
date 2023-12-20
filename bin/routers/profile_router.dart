import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../handlers/profile_handler.dart';
import '../middlewares/check_authority.dart';

class ProfileRouter {
  Handler get profileRouter {
    final profileRouter = Router();
    profileRouter.get('/', profile);
    final pipline =
        Pipeline().addMiddleware(checkAuthority()).addHandler(profileRouter);
    return pipline;
  }
}
