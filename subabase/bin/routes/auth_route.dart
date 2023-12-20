import 'package:shelf_router/shelf_router.dart';


import '../handlers/delete_account.dart';
import '../handlers/login_handler.dart';
import '../handlers/create_handler.dart';

class AuthRoute {
  Router get route {
    final appRoutre = Router();

    appRoutre
      ..post("/create-account", createHandler)
      ..post("/login", loginHandler)
       ..delete("/delete-account", deleteAccountHandler);;

    return appRoutre;
  }
}
