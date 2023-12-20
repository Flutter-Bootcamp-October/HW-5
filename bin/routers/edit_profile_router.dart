import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../handlers/edit_profile_handler.dart';
import '../middlewares/check_authority.dart';

class EditProfileRouter {
  Handler get editProfileRouter {
    final editProfileRouter = Router();
    editProfileRouter.post('/', editProfile);
    final pipline = Pipeline()
        .addMiddleware(checkAuthority())
        .addHandler(editProfileRouter);
    return pipline;
  }
}
