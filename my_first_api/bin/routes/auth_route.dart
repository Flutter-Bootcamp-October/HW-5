import 'package:shelf_router/shelf_router.dart';


import '../handlers/auth_handlers/sign_in_handler.dart';
import '../handlers/auth_handlers/sign_up_handler.dart';
import '../handlers/delete_accont.dart';




class AuthRoute {
  Router get route {
    return Router()
      ..post("/create-account", signUpHandler)
      ..post("/login", signInHandler)
      ..post("/delete", deleteAccountHandler);

  }
  


}
