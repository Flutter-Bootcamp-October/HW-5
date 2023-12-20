import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'create_account._router.dart';
import 'delete_account_router.dart';
import 'edit_profile_router.dart';
import 'login_router.dart';
import 'profile_router.dart';

class MainRouter {
  Router get mainRouter {
    final mainRouter = Router();

    mainRouter
      ..post('/', (Request req) {
        return Response.ok('Hello');
      })
      ..mount('/create-account', CreateAccountRouter().createAccountRouter)
      ..mount('/login', LoginRouter().loginRouter)
      ..mount('/profile', ProfileRouter().profileRouter)
      ..mount('/edit-profile', EditProfileRouter().editProfileRouter)
      ..mount('/delete-account', DeleteAccountRouter().deleteAccountRouter)
      ..all('/<ignore|.*>', (Request req) {
        return Response.ok('Page not found! 404');
      });

    return mainRouter;
  }
}
